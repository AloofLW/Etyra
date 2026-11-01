import 'package:drift/drift.dart';

import 'migrations/schema_migrations.dart';
import 'tables/content_tables.dart';
import 'tables/study_tables.dart';

part 'app_database.g.dart';

/// App composition supplies a connection; importing this file opens no database.
/// The generated part is intentionally deferred to authorized code generation.
@DriftDatabase(
  tables: [
    Roots,
    Affixes,
    Words,
    WordComponents,
    Examples,
    SeedImports,
    LearningStates,
    StudySessions,
    StudySessionItems,
    StudyLogs,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => currentSchemaVersion;

  @override
  MigrationStrategy get migration => schemaMigrations(this);
}
