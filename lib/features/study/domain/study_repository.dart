import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import 'study_models.dart';

abstract interface class StudyRepository {
  Future<Result<StudySessionStart>> startStudySession(
    StudyMode mode, {
    List<String>? contentIds,
  });
  Future<Result<AnswerResult>> submitAnswer(AnswerInput input);
  Future<Result<AnswerResult>> skipItem(String sessionId, String itemId);
  Future<Result<SessionSummary>> finishSession(String sessionId);
  Future<Result<SessionSummary>> abandonSession(String sessionId);
}

abstract interface class LearningStateRepository {
  /// Missing state for existing content is represented as newItem / count 0.
  Future<Result<LearningState>> getState(
    ContentType contentType,
    String contentId,
  );
}
