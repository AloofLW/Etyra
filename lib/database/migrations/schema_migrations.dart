import 'package:drift/drift.dart';

const currentSchemaVersion = 1;

/// No previous released schema exists. Unknown upgrade paths fail closed;
/// future versions must add explicit, verified incremental migration steps.
MigrationStrategy schemaMigrations(GeneratedDatabase database) =>
    MigrationStrategy(
      onCreate: (migrator) => migrator.createAll(),
      onUpgrade: (migrator, from, to) async {
        throw UnsupportedError('No verified migration from $from to $to');
      },
      beforeOpen: (details) async {
        await database.customStatement('PRAGMA foreign_keys = ON');
      },
    );
