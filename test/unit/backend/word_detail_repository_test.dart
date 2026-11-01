import 'package:drift/native.dart';
import 'package:etyra/database/app_database.dart';
import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/shared/data/content_mapper.dart';
import 'package:etyra/features/shared/data/drift_content_repository.dart';
import 'package:etyra/features/shared/data/in_memory_content_repository.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:etyra/features/words/application/word_queries.dart';
import 'package:etyra/features/words/domain/word.dart';
import 'package:etyra/features/words/domain/word_detail.dart';
import 'package:flutter_test/flutter_test.dart';

T value<T>(Result<T> result) {
  expect(result, isA<Success<T>>());
  return (result as Success<T>).value;
}

void expectNotFound<T>(Result<T> result) {
  expect(result, isA<Failure<T>>());
  expect((result as Failure<T>).error.kind, FailureKind.notFound);
}

void main() {
  final source = SourceRef(
    id: 'source-test',
    title: 'TEST_ONLY',
    url: 'https://example.invalid/source',
    locator: 'p-test',
    licenseName: 'TEST_ONLY',
    attributionText: 'TEST_ONLY',
    accessedAt: DateTime.utc(2026, 1, 2),
  );
  final word = Word(
    id: 'word',
    word: 'TEST_ONLY',
    normalizedWord: 'test_only',
    definition: 'TEST_ONLY',
    sources: [source],
  );
  final linkedRoot = Root(
    id: 'root',
    lemma: 'TEST_ONLY',
    displayForm: 'TEST_ONLY',
    language: 'TEST_ONLY',
    meaning: 'TEST_ONLY',
    verificationStatus: VerificationStatus.verified,
    sources: [source],
  );
  final unrelatedRoot = Root(
    id: 'unrelated',
    lemma: 'TEST_ONLY',
    displayForm: 'TEST_ONLY',
    language: 'TEST_ONLY',
    meaning: 'TEST_ONLY',
    verificationStatus: VerificationStatus.unverified,
    sources: [source],
  );
  final affix = Affix(
    id: 'affix',
    form: 'TEST_ONLY',
    kind: AffixKind.prefix,
    meaning: 'TEST_ONLY',
    verificationStatus: VerificationStatus.verified,
    sources: [source],
  );
  final rootComponent = WordComponent(
    wordId: 'word',
    componentType: ComponentType.root,
    componentId: 'root',
    role: ComponentRole.root,
    confidence: 0.7,
    sources: [source],
  );
  final affixComponent = WordComponent(
    wordId: 'word',
    componentType: ComponentType.affix,
    componentId: 'affix',
    role: ComponentRole.prefix,
    sources: [source],
  );
  final example = ExampleSentence(
    id: 'example',
    wordId: 'word',
    sentence: 'TEST_ONLY',
    sources: [source],
  );

  test('WordDetail copies and protects every collection', () {
    final roots = [linkedRoot];
    final affixes = [affix];
    final components = [rootComponent];
    final examples = [example];
    final detail = WordDetail(
      word: word,
      roots: roots,
      affixes: affixes,
      components: components,
      examples: examples,
    );
    roots.clear();
    affixes.clear();
    components.clear();
    examples.clear();
    expect(detail.roots, hasLength(1));
    expect(detail.affixes, hasLength(1));
    expect(detail.components, hasLength(1));
    expect(detail.examples, hasLength(1));
    expect(() => detail.roots.clear(), throwsUnsupportedError);
    expect(() => detail.affixes.clear(), throwsUnsupportedError);
    expect(() => detail.components.clear(), throwsUnsupportedError);
    expect(() => detail.examples.clear(), throwsUnsupportedError);
  });

  test(
    'in-memory detail uses explicit links and the application use case',
    () async {
      final repository = InMemoryContentRepository(
        words: [word],
        roots: [unrelatedRoot, linkedRoot],
        affixes: [affix],
        components: [rootComponent, affixComponent],
        examples: [example],
      );
      final detail = value(await GetWordDetail(repository)('word'));
      expect(detail.word, same(word));
      expect(detail.roots.map((r) => r.id), ['root']);
      expect(detail.affixes.map((a) => a.id), ['affix']);
      expect(detail.components, containsAll([rootComponent, affixComponent]));
      expect(detail.examples.single, same(example));
      expect(
        detail.components
            .where((c) => c.componentType == ComponentType.root)
            .single
            .sources
            .single,
        same(source),
      );
      expectNotFound(await repository.getWordDetail('missing'));
      final empty = value(
        await InMemoryContentRepository(
          words: [word],
          roots: [unrelatedRoot],
        ).getWordDetail('word'),
      );
      expect(empty.roots, isEmpty);
      expect(empty.affixes, isEmpty);
      expect(empty.components, isEmpty);
      expect(empty.examples, isEmpty);
    },
  );

  group('SQLite detail', () {
    late AppDatabase database;
    late DriftContentRepository repository;
    setUp(() async {
      database = AppDatabase(NativeDatabase.memory());
      repository = DriftContentRepository(database);
      final sources = const ContentMapper().sourcesToJson([source]);
      await database.customStatement(
        'INSERT INTO words (id, word, normalized_word, definition, source_refs) VALUES (?, ?, ?, ?, ?)',
        ['word', 'TEST_ONLY', 'test_only', 'TEST_ONLY', sources],
      );
      for (final id in ['root', 'unrelated']) {
        await database.customStatement(
          'INSERT INTO roots (id, lemma, display_form, language, meaning, verification_status, source_refs, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            id,
            'TEST_ONLY',
            'TEST_ONLY',
            'TEST_ONLY',
            'TEST_ONLY',
            'verified',
            sources,
            0,
            0,
          ],
        );
      }
      await database.customStatement(
        'INSERT INTO affixes (id, form, kind, meaning, verification_status, source_refs) VALUES (?, ?, ?, ?, ?, ?)',
        [
          'affix',
          'TEST_ONLY',
          'future-kind',
          'TEST_ONLY',
          'future-status',
          sources,
        ],
      );
    });
    tearDown(() async => database.close());

    test(
      'missing word is NotFound; no relationships returns empty collections',
      () async {
        expectNotFound(await repository.getWordDetail('missing'));
        final detail = value(await GetWordDetail(repository)('word'));
        expect(detail.word.id, 'word');
        expect(detail.roots, isEmpty);
        expect(detail.affixes, isEmpty);
        expect(detail.components, isEmpty);
        expect(detail.examples, isEmpty);
      },
    );

    test('keeps sources and relations; ignores unknown types and never infers links', () async {
      final sources = const ContentMapper().sourcesToJson([source]);
      for (final row in [
        ['root', 'root', 'root'],
        ['root', 'root', 'other'],
        ['affix', 'affix', 'future-role'],
        ['future-type', 'unrelated', 'root'],
      ]) {
        await database.customStatement(
          'INSERT INTO word_components (word_id, component_type, component_id, role, confidence, source_refs) VALUES (?, ?, ?, ?, ?, ?)',
          ['word', row[0], row[1], row[2], 0.7, sources],
        );
      }
      await database.customStatement(
        'INSERT INTO examples (id, word_id, sentence, translation, source_refs) VALUES (?, ?, ?, ?, ?)',
        ['example', 'word', 'TEST_ONLY', 'TEST_ONLY', sources],
      );
      final detail = value(await repository.getWordDetail('word'));
      expect(detail.roots.map((r) => r.id), ['root']);
      expect(detail.affixes.map((a) => a.id), ['affix']);
      expect(detail.components, hasLength(3));
      expect(
        detail.components
            .where((c) => c.componentType == ComponentType.affix)
            .single
            .role,
        ComponentRole.unknown,
      );
      expect(detail.affixes.single.kind, AffixKind.unknown);
      expect(
        detail.affixes.single.verificationStatus,
        VerificationStatus.unverified,
      );
      expect(detail.examples.single.id, 'example');
      for (final actual in [
        detail.word.sources.single,
        detail.roots.single.sources.single,
        detail.affixes.single.sources.single,
        detail.components.first.sources.single,
        detail.examples.single.sources.single,
      ]) {
        expect(
          const ContentMapper().sourceToJson(actual),
          const ContentMapper().sourceToJson(source),
        );
      }
      expect(() => detail.components.clear(), throwsUnsupportedError);
    });

    test('malformed stored source maps to a stable storage failure', () async {
      await database.customStatement(
        "UPDATE words SET source_refs = 'invalid' WHERE id = 'word'",
      );
      final result = await repository.getWordDetail('word');
      expect(result, isA<Failure<WordDetail>>());
      expect((result as Failure<WordDetail>).error.kind, FailureKind.storage);
    });
  });
}
