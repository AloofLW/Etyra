import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

final class GetLearningState {
  const GetLearningState(this.repository);
  final LearningStateRepository repository;
  Future<Result<LearningState>> call(ContentType type, String contentId) =>
      repository.getState(type, contentId);
}
