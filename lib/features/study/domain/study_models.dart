import '../../shared/domain/content_types.dart';

/// `newItem` is stored as `new`, since `new` is a Dart keyword.
enum LearningStage {
  newItem('new'),
  learning('learning'),
  learned('learned');

  const LearningStage(this.storageValue);
  final String storageValue;
}

enum StudyMode { roots, words }

enum AnswerRating { recalled, needsPractice }

enum AnswerOutcome { recalled, needsPractice, skipped }

enum StudySessionStatus { active, completed, abandoned }

final class LearningState {
  LearningState({
    required this.contentId,
    required this.contentType,
    required this.stage,
    DateTime? dueAt,
    DateTime? lastStudiedAt,
    required this.studyCount,
  }) : dueAt = dueAt?.toUtc(),
       lastStudiedAt = lastStudiedAt?.toUtc();
  final String contentId;
  final ContentType contentType;
  final LearningStage stage;
  final DateTime? dueAt;
  final DateTime? lastStudiedAt;
  final int studyCount;
}

final class StudyCard {
  StudyCard({
    required this.itemId,
    required this.contentType,
    required this.prompt,
    required this.answer,
    required Iterable<String> hints,
    required this.position,
    required this.total,
  }) : hints = List.unmodifiable(hints);
  final String itemId;
  final ContentType contentType;
  final String prompt;
  final String answer;
  final List<String> hints;
  final int position;
  final int total;
}

final class AnswerInput {
  const AnswerInput({
    required this.sessionId,
    required this.itemId,
    required this.rating,
    this.responseMilliseconds,
  });
  final String sessionId;
  final String itemId;
  final AnswerRating rating;
  final int? responseMilliseconds;
}

final class AnswerResult {
  const AnswerResult({
    required this.sessionId,
    required this.itemId,
    required this.outcome,
    required this.nextCard,
    required this.sessionFinished,
    required this.completedCount,
    required this.skippedCount,
    required this.totalCount,
  });
  final String sessionId;
  final String itemId;
  final AnswerOutcome outcome;
  final StudyCard? nextCard;
  final bool sessionFinished;
  final int completedCount;
  final int skippedCount;
  final int totalCount;
}

final class StudySession {
  StudySession({
    required this.id,
    required this.mode,
    required this.status,
    required DateTime startedAt,
    DateTime? finishedAt,
  }) : startedAt = startedAt.toUtc(),
       finishedAt = finishedAt?.toUtc();
  final String id;
  final StudyMode mode;
  final StudySessionStatus status;
  final DateTime startedAt;
  final DateTime? finishedAt;
}

final class StudySessionStart {
  const StudySessionStart({
    required this.session,
    required this.firstCard,
    required this.totalCount,
  });
  final StudySession? session;
  final StudyCard? firstCard;
  final int totalCount;
}

final class SessionSummary {
  SessionSummary({
    required this.sessionId,
    required this.mode,
    required this.status,
    required this.itemCount,
    required this.completedCount,
    required this.skippedCount,
    required DateTime startedAt,
    required DateTime finishedAt,
  }) : startedAt = startedAt.toUtc(),
       finishedAt = finishedAt.toUtc();
  final String sessionId;
  final StudyMode mode;
  final StudySessionStatus status;
  final int itemCount;
  final int completedCount;
  final int skippedCount;
  final DateTime startedAt;
  final DateTime finishedAt;
}
