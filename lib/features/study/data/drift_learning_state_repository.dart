import 'package:drift/drift.dart';

import '../../shared/domain/content_types.dart';
import '../../shared/domain/result.dart';
import '../domain/study_models.dart';
import '../domain/study_repository.dart';

final class DriftLearningStateRepository implements LearningStateRepository {
  const DriftLearningStateRepository(this.database);
  final GeneratedDatabase database;

  @override
  Future<Result<LearningState>> getState(
    ContentType contentType,
    String contentId,
  ) async {
    try {
      return await database.transaction(() async {
        final table = contentType == ContentType.root ? 'roots' : 'words';
        final content = await database
            .customSelect(
              'SELECT id FROM $table WHERE id = ?',
              variables: [Variable<String>(contentId)],
            )
            .get();
        if (content.isEmpty) {
          return const Failure<LearningState>(
            DomainFailure(FailureKind.notFound, 'content.not_found'),
          );
        }
        final rows = await database
            .customSelect(
              'SELECT * FROM learning_states WHERE content_type = ? AND content_id = ?',
              variables: [
                Variable<String>(contentType.name),
                Variable<String>(contentId),
              ],
            )
            .get();
        if (rows.isEmpty) {
          return Success(
            LearningState(
              contentType: contentType,
              contentId: contentId,
              stage: LearningStage.newItem,
              studyCount: 0,
            ),
          );
        }
        final row = rows.single;
        final rawStage = row.read<String>('stage');
        final stage = LearningStage.values
            .where((s) => s.storageValue == rawStage)
            .firstOrNull;
        // Preserve unknown state on disk, and let UI show a stable failure.
        if (stage == null) {
          return const Failure<LearningState>(
            DomainFailure(
              FailureKind.unsupported,
              'study.unknown_learning_stage',
            ),
          );
        }
        final timestamp = row.readNullable<int>('last_studied_at');
        return Success(
          LearningState(
            contentType: contentType,
            contentId: contentId,
            stage: stage,
            studyCount: row.read<int>('study_count'),
            lastStudiedAt: timestamp == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true),
          ),
        );
      });
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }
}
