import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

final class StartStudySession {
  const StartStudySession(this.repository);
  final StudyRepository repository;
  Future<Result<StudySessionStart>> call(
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
    return repository.startStudySession(
      mode,
      contentIds: contentIds == null ? null : List.unmodifiable(contentIds),
    );
  }
}

final class SubmitAnswer {
  const SubmitAnswer(this.repository);
  final StudyRepository repository;
  Future<Result<AnswerResult>> call(AnswerInput input) {
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
    return repository.submitAnswer(input);
  }
}

final class SkipItem {
  const SkipItem(this.repository);
  final StudyRepository repository;
  Future<Result<AnswerResult>> call(String sessionId, String itemId) =>
      repository.skipItem(sessionId, itemId);
}

final class FinishSession {
  const FinishSession(this.repository);
  final StudyRepository repository;
  Future<Result<SessionSummary>> call(String sessionId) =>
      repository.finishSession(sessionId);
}

final class AbandonSession {
  const AbandonSession(this.repository);
  final StudyRepository repository;
  Future<Result<SessionSummary>> call(String sessionId) =>
      repository.abandonSession(sessionId);
}
