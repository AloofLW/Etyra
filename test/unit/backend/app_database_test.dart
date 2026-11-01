import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:etyra/database/app_database.dart';
import 'package:etyra/features/content_import/data/seed_importer.dart';
import 'package:etyra/features/content_import/data/seed_package.dart';
import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:etyra/features/words/domain/word.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('creates the v1 schema with foreign keys enabled', () async {
    final tables = await database
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .map((row) => row.read<String>('name'))
        .get();

    expect(
      tables,
      containsAll([
        'roots',
        'affixes',
        'words',
        'word_components',
        'examples',
        'learning_states',
        'study_sessions',
        'study_session_items',
        'study_logs',
        'seed_imports',
      ]),
    );
    final foreignKeys = await database
        .customSelect('PRAGMA foreign_keys')
        .getSingle();
    expect(foreignKeys.read<int>('foreign_keys'), 1);
  });

  test('seed import is idempotent and rejects changed content', () async {
    final importer = SeedImporter(
      database,
      clock: () => DateTime.utc(2026, 11, 1),
    );
    final initial = _package(meaning: 'around');

    final first = await importer.importPackage(initial);
    final repeated = await importer.importPackage(initial);
    final changed = await importer.importPackage(_package(meaning: 'circle'));

    expect(first, isA<Success>());
    expect((first as Success).value.alreadyImported, isFalse);
    expect(repeated, isA<Success>());
    expect((repeated as Success).value.alreadyImported, isTrue);
    expect(changed, isA<Failure>());
    expect((changed as Failure).error.kind, FailureKind.conflict);

    final count = await database
        .customSelect('SELECT COUNT(*) AS count FROM roots')
        .getSingle();
    expect(count.read<int>('count'), 1);
    final receipts = await database
        .customSelect('SELECT COUNT(*) AS count FROM seed_imports')
        .getSingle();
    expect(receipts.read<int>('count'), 1);
  });
}

SeedPackage _package({required String meaning}) {
  final source = SourceRef(
    id: 'test-source',
    title: 'Test only fixture',
    publisher: 'Etyra tests',
    url: 'https://example.invalid/test-fixture',
    licenseName: 'Test fixture only',
    accessedAt: DateTime.utc(2026, 11, 1),
  );
  return SeedPackage(
    packageId: 'test-package',
    version: 1,
    reviewedBy: 'test-reviewer',
    reviewReference: 'TEST_ONLY',
    reviewedAt: DateTime.utc(2026, 11, 1),
    approvedForRedistribution: true,
    roots: [
      Root(
        id: 'test-root',
        lemma: 'circ',
        displayForm: 'circ',
        language: 'la',
        meaning: meaning,
        verificationStatus: VerificationStatus.verified,
        sources: [source],
      ),
    ],
    words: [
      Word(
        id: 'test-word',
        word: 'circle',
        normalizedWord: 'circle',
        definition: 'TEST_ONLY',
        sources: [source],
      ),
    ],
  );
}
