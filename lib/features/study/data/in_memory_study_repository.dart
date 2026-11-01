import 'dart:math';

import '../../shared/data/in_memory_content_repository.dart';
import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

/// A fake event is distinct from an FSRS review record.
final class MemoryStudyEvent {
  const MemoryStudyEvent({
    required this.sessionId,
    required this.itemId,
    required this.contentType,
    required this.outcome,
    required this.answeredAt,
    this.responseMilliseconds,
  });
  final String sessionId;
  final String itemId;
  final ContentType contentType;
  final AnswerOutcome outcome;
  final DateTime answeredAt;
  final int? responseMilliseconds;
}

/// All mutations occur synchronously before futures complete, so duplicate
/// submissions cannot interleave in this fake. Production requires a transaction.
final class InMemoryStudyRepository
    implements StudyRepository, LearningStateRepository {
  InMemoryStudyRepository(this.content, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;
  final InMemoryContentRepository content;
  final DateTime Function() _clock;
  final _random = Random.secure();
  final _sessions = <String, _MemorySession>{};
  final _states = <(ContentType, String), LearningState>{};
  final _events = <MemoryStudyEvent>[];
  List<MemoryStudyEvent> get events => List.unmodifiable(_events);

  @override
  Future<Result<StudySessionStart>> startStudySession(
    StudyMode mode, {
    List<String>? contentIds,
  }) async {
    if (contentIds != null &&
        (contentIds.any((id) => id.trim().isEmpty) ||
            contentIds.toSet().length != contentIds.length)) {
      return const Failure(
        DomainFailure(FailureKind.validation, 'study.invalid_content_ids'),
      );
    }
    final type = mode == StudyMode.roots ? ContentType.root : ContentType.word;
    final available = <String, (String, String)>{
      if (mode == StudyMode.roots)
        for (final root in content.roots)
          root.id: (root.displayForm, root.meaning),
      if (mode == StudyMode.words)
        for (final word in content.words)
          word.id: (word.word, word.translation ?? word.definition),
    };
    final ids = contentIds == null
        ? (available.keys.toList()..sort())
        : List<String>.of(contentIds);
    if (ids.any((id) => !available.containsKey(id))) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'content.not_found'),
      );
    }
    if (ids.isEmpty) {
      return const Success(
        StudySessionStart(session: null, firstCard: null, totalCount: 0),
      );
    }
    final cards = <StudyCard>[
      for (var i = 0; i < ids.length; i++)
        StudyCard(
          itemId: ids[i],
          contentType: type,
          prompt: available[ids[i]]!.$1,
          answer: available[ids[i]]!.$2,
          hints: const [],
          position: i + 1,
          total: ids.length,
        ),
    ];
    String id;
    do {
      id = List.generate(
        16,
        (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
      ).join();
    } while (_sessions.containsKey(id));
    final session = StudySession(
      id: id,
      mode: mode,
      status: StudySessionStatus.active,
      startedAt: _clock(),
    );
    _sessions[id] = _MemorySession(session, cards);
    return Success(
      StudySessionStart(
        session: session,
        firstCard: cards.first,
        totalCount: cards.length,
      ),
    );
  }

  @override
  Future<Result<AnswerResult>> submitAnswer(AnswerInput input) async {
    if (input.responseMilliseconds != null && input.responseMilliseconds! < 0) {
      return const Failure(
        DomainFailure(FailureKind.validation, 'study.invalid_answer'),
      );
    }
    return _record(
      input.sessionId,
      input.itemId,
      input.rating == AnswerRating.recalled
          ? AnswerOutcome.recalled
          : AnswerOutcome.needsPractice,
      input.responseMilliseconds,
    );
  }

  @override
  Future<Result<AnswerResult>> skipItem(
    String sessionId,
    String itemId,
  ) async => _record(sessionId, itemId, AnswerOutcome.skipped, null);

  Result<AnswerResult> _record(
    String sessionId,
    String itemId,
    AnswerOutcome outcome,
    int? responseMs,
  ) {
    final session = _sessions[sessionId];
    if (session == null) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'study.session_not_found'),
      );
    }
    if (session.session.status != StudySessionStatus.active ||
        session.handled.contains(itemId)) {
      return const Failure(
        DomainFailure(FailureKind.conflict, 'study.session_or_item_closed'),
      );
    }
    final card = session.next;
    if (card == null || card.itemId != itemId) {
      return const Failure(
        DomainFailure(FailureKind.conflict, 'study.item_not_current'),
      );
    }
    final now = _clock().toUtc();
    _events.add(
      MemoryStudyEvent(
        sessionId: sessionId,
        itemId: itemId,
        contentType: card.contentType,
        outcome: outcome,
        answeredAt: now,
        responseMilliseconds: responseMs,
      ),
    );
    session.handled.add(itemId);
    if (outcome == AnswerOutcome.skipped) {
      session.skipped++;
    } else {
      session.completed++;
      final previous = _states[(card.contentType, itemId)];
      // ADR-014: a recalled answer completes first-round learning for this item.
      // Session completion and later needsPractice answers cannot undo it.
      _states[(card.contentType, itemId)] = LearningState(
        contentId: itemId,
        contentType: card.contentType,
        stage:
            outcome == AnswerOutcome.recalled ||
                previous?.stage == LearningStage.learned
            ? LearningStage.learned
            : LearningStage.learning,
        lastStudiedAt: now,
        studyCount: (previous?.studyCount ?? 0) + 1,
      );
    }
    if (session.next == null) {
      _close(session, StudySessionStatus.completed, now);
    }
    return Success(
      AnswerResult(
        sessionId: sessionId,
        itemId: itemId,
        outcome: outcome,
        nextCard: session.next,
        sessionFinished: session.next == null,
        completedCount: session.completed,
        skippedCount: session.skipped,
        totalCount: session.cards.length,
      ),
    );
  }

  @override
  Future<Result<SessionSummary>> finishSession(String sessionId) async {
    final session = _sessions[sessionId];
    if (session == null) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'study.session_not_found'),
      );
    }
    if (session.session.status == StudySessionStatus.abandoned ||
        session.next != null) {
      return const Failure(
        DomainFailure(FailureKind.conflict, 'study.session_not_complete'),
      );
    }
    return Success(_summary(session));
  }

  @override
  Future<Result<SessionSummary>> abandonSession(String sessionId) async {
    final session = _sessions[sessionId];
    if (session == null) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'study.session_not_found'),
      );
    }
    if (session.session.status == StudySessionStatus.completed) {
      return const Failure(
        DomainFailure(FailureKind.conflict, 'study.session_already_completed'),
      );
    }
    if (session.session.status == StudySessionStatus.active) {
      _close(session, StudySessionStatus.abandoned, _clock().toUtc());
    }
    return Success(_summary(session));
  }

  void _close(_MemorySession state, StudySessionStatus status, DateTime now) {
    state.session = StudySession(
      id: state.session.id,
      mode: state.session.mode,
      status: status,
      startedAt: state.session.startedAt,
      finishedAt: now,
    );
  }

  SessionSummary _summary(_MemorySession state) => SessionSummary(
    sessionId: state.session.id,
    mode: state.session.mode,
    status: state.session.status,
    itemCount: state.cards.length,
    completedCount: state.completed,
    skippedCount: state.skipped,
    startedAt: state.session.startedAt,
    finishedAt: state.session.finishedAt!,
  );

  @override
  Future<Result<LearningState>> getState(
    ContentType contentType,
    String contentId,
  ) async {
    final exists = contentType == ContentType.root
        ? content.roots.any((r) => r.id == contentId)
        : content.words.any((w) => w.id == contentId);
    if (!exists) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'content.not_found'),
      );
    }
    return Success(
      _states[(contentType, contentId)] ??
          LearningState(
            contentId: contentId,
            contentType: contentType,
            stage: LearningStage.newItem,
            studyCount: 0,
          ),
    );
  }
}

final class _MemorySession {
  _MemorySession(this.session, this.cards);
  StudySession session;
  final List<StudyCard> cards;
  final handled = <String>{};
  int completed = 0;
  int skipped = 0;
  StudyCard? get next =>
      handled.length < cards.length ? cards[handled.length] : null;
}
