import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart' show SqliteException;

import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

/// SQLite-backed learning commands. A transaction owns each complete change,
/// including the snapshot, event, counters, state, and session status.
final class DriftStudyRepository implements StudyRepository {
  DriftStudyRepository(this.database, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  final GeneratedDatabase database;
  final DateTime Function() _clock;
  final Random _random = Random.secure();

  String _id() => List.generate(
    16,
    (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();

  Future<Result<T>> _transaction<T>(Future<T> Function() operation) async {
    for (var attempt = 0; ; attempt++) {
      try {
        return Success(await database.transaction(operation));
      } on _StudyFailure catch (failure) {
        return Failure(failure.error);
      } on SqliteException catch (error) {
        // Another connection may hold SQLite's write lock. Retry the entire
        // transaction, including its eligibility checks, so a concurrent
        // duplicate becomes Conflict after the first transaction commits.
        if ((error.resultCode == 5 || error.resultCode == 6) && attempt < 5) {
          await Future<void>.delayed(Duration(milliseconds: 10 << attempt));
          continue;
        }
        return const Failure(
          DomainFailure(FailureKind.storage, 'storage.write_failed'),
        );
      } catch (_) {
        return const Failure(
          DomainFailure(FailureKind.storage, 'storage.write_failed'),
        );
      }
    }
  }

  Never _fail(FailureKind kind, String key) =>
      throw _StudyFailure(DomainFailure(kind, key));

  Future<List<QueryRow>> _select(
    String sql, [
    List<Variable> variables = const [],
  ]) => database.customSelect(sql, variables: variables).get();

  @override
  Future<Result<StudySessionStart>> startStudySession(
    StudyMode mode, {
    List<String>? contentIds,
  }) {
    if (contentIds != null &&
        (contentIds.any((id) => id.trim().isEmpty) ||
            contentIds.toSet().length != contentIds.length)) {
      return Future.value(
        const Failure(
          DomainFailure(FailureKind.validation, 'study.invalid_content_ids'),
        ),
      );
    }
    final ids = contentIds == null ? null : List<String>.of(contentIds);
    return _transaction(() async {
      final isRoots = mode == StudyMode.roots;
      final type = isRoots ? ContentType.root : ContentType.word;
      final table = isRoots ? 'roots' : 'words';
      final promptColumn = isRoots ? 'display_form' : 'word';
      final answerColumn = isRoots
          ? 'meaning'
          : 'COALESCE(translation, definition)';
      final rows = await _select(
        'SELECT id, $promptColumn AS prompt, $answerColumn AS answer FROM $table ORDER BY id',
      );
      final available = {for (final row in rows) row.read<String>('id'): row};
      final selected = ids ?? available.keys.toList();
      if (selected.any((id) => !available.containsKey(id))) {
        _fail(FailureKind.notFound, 'content.not_found');
      }
      if (selected.isEmpty) {
        return const StudySessionStart(
          session: null,
          firstCard: null,
          totalCount: 0,
        );
      }
      final sessionId = _id();
      final startedAt = _clock().toUtc();
      await database.customStatement(
        'INSERT INTO study_sessions (id, mode, status, started_at, item_count, completed_count, skipped_count) VALUES (?, ?, ?, ?, ?, 0, 0)',
        [
          sessionId,
          mode.name,
          StudySessionStatus.active.name,
          startedAt.millisecondsSinceEpoch,
          selected.length,
        ],
      );
      StudyCard? first;
      for (var i = 0; i < selected.length; i++) {
        final row = available[selected[i]]!;
        final card = StudyCard(
          itemId: selected[i],
          contentType: type,
          prompt: row.read<String>('prompt'),
          answer: row.read<String>('answer'),
          hints: const [],
          position: i + 1,
          total: selected.length,
        );
        first ??= card;
        await database.customStatement(
          'INSERT INTO study_session_items (session_id, item_id, content_type, prompt, answer, hints_json, position) VALUES (?, ?, ?, ?, ?, ?, ?)',
          [
            sessionId,
            card.itemId,
            type.name,
            card.prompt,
            card.answer,
            '[]',
            card.position,
          ],
        );
      }
      return StudySessionStart(
        session: StudySession(
          id: sessionId,
          mode: mode,
          status: StudySessionStatus.active,
          startedAt: startedAt,
        ),
        firstCard: first,
        totalCount: selected.length,
      );
    });
  }

  @override
  Future<Result<AnswerResult>> submitAnswer(AnswerInput input) {
    if (input.sessionId.trim().isEmpty ||
        input.itemId.trim().isEmpty ||
        (input.responseMilliseconds != null &&
            input.responseMilliseconds! < 0)) {
      return Future.value(
        const Failure(
          DomainFailure(FailureKind.validation, 'study.invalid_answer'),
        ),
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
  Future<Result<AnswerResult>> skipItem(String sessionId, String itemId) =>
      _record(sessionId, itemId, AnswerOutcome.skipped, null);

  Future<Result<AnswerResult>> _record(
    String sessionId,
    String itemId,
    AnswerOutcome outcome,
    int? responseMs,
  ) => _transaction(() async {
    final session = await _session(sessionId);
    final status = _status(session);
    if (status != StudySessionStatus.active) {
      _fail(FailureKind.conflict, 'study.session_or_item_closed');
    }
    _mode(session);
    final current = await _next(sessionId, session.read<int>('item_count'));
    if (current == null || current.itemId != itemId) {
      _fail(FailureKind.conflict, 'study.item_not_current');
    }
    final card = current;
    final now = _clock().toUtc().millisecondsSinceEpoch;
    if (outcome != AnswerOutcome.skipped) {
      final state = await _select(
        'SELECT stage FROM learning_states WHERE content_type = ? AND content_id = ?',
        [Variable<String>(card.contentType.name), Variable<String>(itemId)],
      );
      if (state.isNotEmpty &&
          !LearningStage.values.any(
            (s) => s.storageValue == state.single.read<String>('stage'),
          )) {
        _fail(FailureKind.unsupported, 'study.unknown_learning_stage');
      }
    }
    await database.customStatement(
      'INSERT INTO study_logs (id, session_id, content_type, content_id, outcome, answered_at, response_ms) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        _id(),
        sessionId,
        card.contentType.name,
        itemId,
        outcome.name,
        now,
        responseMs,
      ],
    );
    if (outcome != AnswerOutcome.skipped) {
      final stage = outcome == AnswerOutcome.recalled
          ? LearningStage.learned.storageValue
          : LearningStage.learning.storageValue;
      await database.customStatement(
        'INSERT INTO learning_states (content_type, content_id, stage, last_studied_at, study_count) VALUES (?, ?, ?, ?, 1) '
        'ON CONFLICT (content_type, content_id) DO UPDATE SET '
        "stage = CASE WHEN learning_states.stage = 'learned' THEN 'learned' ELSE excluded.stage END, "
        'last_studied_at = excluded.last_studied_at, study_count = learning_states.study_count + 1',
        [card.contentType.name, itemId, stage, now],
      );
    }
    final completed =
        session.read<int>('completed_count') +
        (outcome == AnswerOutcome.skipped ? 0 : 1);
    final skipped =
        session.read<int>('skipped_count') +
        (outcome == AnswerOutcome.skipped ? 1 : 0);
    final total = session.read<int>('item_count');
    final finished = completed + skipped == total;
    await database.customStatement(
      'UPDATE study_sessions SET completed_count = ?, skipped_count = ?, status = ?, finished_at = ? WHERE id = ?',
      [
        completed,
        skipped,
        finished
            ? StudySessionStatus.completed.name
            : StudySessionStatus.active.name,
        finished ? now : null,
        sessionId,
      ],
    );
    final next = await _next(sessionId, total);
    return AnswerResult(
      sessionId: sessionId,
      itemId: itemId,
      outcome: outcome,
      nextCard: next,
      sessionFinished: finished,
      completedCount: completed,
      skippedCount: skipped,
      totalCount: total,
    );
  });

  @override
  Future<Result<SessionSummary>> finishSession(String sessionId) =>
      _transaction(() async {
        final session = await _session(sessionId);
        if (_status(session) != StudySessionStatus.completed) {
          _fail(FailureKind.conflict, 'study.session_not_complete');
        }
        return _summary(session);
      });

  @override
  Future<Result<SessionSummary>> abandonSession(
    String sessionId,
  ) => _transaction(() async {
    final session = await _session(sessionId);
    final status = _status(session);
    if (status == StudySessionStatus.completed) {
      _fail(FailureKind.conflict, 'study.session_already_completed');
    }
    if (status == StudySessionStatus.active) {
      await database.customStatement(
        'UPDATE study_sessions SET status = ?, finished_at = ? WHERE id = ?',
        [
          StudySessionStatus.abandoned.name,
          _clock().toUtc().millisecondsSinceEpoch,
          sessionId,
        ],
      );
      return _summary(await _session(sessionId));
    }
    return _summary(session);
  });

  Future<QueryRow> _session(String id) async {
    final rows = await _select('SELECT * FROM study_sessions WHERE id = ?', [
      Variable<String>(id),
    ]);
    if (rows.isEmpty) _fail(FailureKind.notFound, 'study.session_not_found');
    return rows.single;
  }

  StudySessionStatus _status(QueryRow row) =>
      knownEnum(StudySessionStatus.values, row.read<String>('status')) ??
      _fail(FailureKind.unsupported, 'study.unknown_session_status');

  StudyMode _mode(QueryRow row) =>
      knownEnum(StudyMode.values, row.read<String>('mode')) ??
      _fail(FailureKind.unsupported, 'study.unknown_session_mode');

  Future<StudyCard?> _next(String sessionId, int total) async {
    final rows = await _select(
      'SELECT i.* FROM study_session_items i WHERE i.session_id = ? '
      'AND NOT EXISTS (SELECT 1 FROM study_logs l WHERE l.session_id = i.session_id AND l.content_id = i.item_id) '
      'ORDER BY i.position LIMIT 1',
      [Variable<String>(sessionId)],
    );
    if (rows.isEmpty) return null;
    final row = rows.single;
    final type =
        knownEnum(ContentType.values, row.read<String>('content_type')) ??
        _fail(FailureKind.unsupported, 'study.unknown_content_type');
    final hints = (jsonDecode(row.read<String>('hints_json')) as List)
        .cast<String>();
    return StudyCard(
      itemId: row.read<String>('item_id'),
      contentType: type,
      prompt: row.read<String>('prompt'),
      answer: row.read<String>('answer'),
      hints: hints,
      position: row.read<int>('position'),
      total: total,
    );
  }

  SessionSummary _summary(QueryRow row) {
    final mode = _mode(row);
    final finished = row.readNullable<int>('finished_at');
    if (finished == null) _fail(FailureKind.storage, 'storage.invalid_session');
    return SessionSummary(
      sessionId: row.read<String>('id'),
      mode: mode,
      status: _status(row),
      itemCount: row.read<int>('item_count'),
      completedCount: row.read<int>('completed_count'),
      skippedCount: row.read<int>('skipped_count'),
      startedAt: DateTime.fromMillisecondsSinceEpoch(
        row.read<int>('started_at'),
        isUtc: true,
      ),
      finishedAt: DateTime.fromMillisecondsSinceEpoch(finished, isUtc: true),
    );
  }
}

final class _StudyFailure implements Exception {
  const _StudyFailure(this.error);
  final DomainFailure error;
}
