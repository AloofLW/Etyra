import 'package:drift/drift.dart';

import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

/// Deliberate persistence boundary for ET-01E. Never pretends an in-memory write
/// was saved. Implement transactional queue/log/state writes after schema QA.
final class DriftStudyRepository implements StudyRepository {
  const DriftStudyRepository(this.database);
  final GeneratedDatabase database;
  Future<Result<T>> _pending<T>() async => const Failure(
    DomainFailure(FailureKind.unsupported, 'study.persistence_not_ready'),
  );

  @override
  Future<Result<StudySessionStart>> startStudySession(
    StudyMode mode, {
    List<String>? contentIds,
  }) => _pending();
  @override
  Future<Result<AnswerResult>> submitAnswer(AnswerInput input) => _pending();
  @override
  Future<Result<AnswerResult>> skipItem(String sessionId, String itemId) =>
      _pending();
  @override
  Future<Result<SessionSummary>> finishSession(String sessionId) => _pending();
  @override
  Future<Result<SessionSummary>> abandonSession(String sessionId) => _pending();
}
