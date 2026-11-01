import 'package:drift/drift.dart';

import '../../roots/domain/root.dart';
import '../../roots/domain/root_repository.dart';
import '../../words/domain/word.dart';
import '../../words/domain/word_detail.dart';
import '../../words/domain/word_repository.dart';
import '../domain/page.dart';
import '../domain/result.dart';
import 'content_mapper.dart';
import 'cursor_codec.dart';

/// SQLite types and row maps stay entirely inside data.
final class DriftContentRepository implements RootRepository, WordRepository {
  const DriftContentRepository(this.database);
  // Accept the Drift query boundary so this data adapter can be analyzed before
  // code generation. Composition supplies the schema-owning AppDatabase.
  final GeneratedDatabase database;
  static const _mapper = ContentMapper();
  static const _codec = CursorCodec();

  Future<Result<T>> _read<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }

  @override
  Future<Result<Page<Root>>> listRoots({
    String? query,
    String? cursor,
    int limit = 30,
  }) => _list('roots', query, cursor, limit, _mapper.root);

  @override
  Future<Result<Page<Word>>> listWords({
    String? query,
    String? cursor,
    int limit = 30,
  }) => _list('words', query, cursor, limit, _mapper.word);

  Future<Result<Page<T>>> _list<T>(
    String table,
    String? query,
    String? cursor,
    int limit,
    T Function(Map<String, dynamic>) map,
  ) async {
    if (limit <= 0) {
      return const Failure(
        DomainFailure(FailureKind.validation, 'pagination.invalid_limit'),
      );
    }
    final q = (query ?? '').trim().toLowerCase();
    String? after;
    try {
      after = _codec.decode(cursor, table, q);
    } on FormatException {
      return const Failure(
        DomainFailure(FailureKind.validation, 'pagination.invalid_cursor'),
      );
    }
    // Table and expression are internal constants, never user-supplied SQL.
    final search = table == 'roots'
        ? "lemma || ' ' || display_form || ' ' || meaning"
        : "word || ' ' || normalized_word || ' ' || definition";
    return _read(() async {
      final rows = await database
          .customSelect(
            'SELECT * FROM $table WHERE instr(lower($search), ?) > 0 '
            '${after == null ? '' : 'AND id > ? '}ORDER BY id LIMIT ?',
            variables: [
              Variable<String>(q),
              if (after != null) Variable<String>(after),
              Variable<int>(limit + 1),
            ],
          )
          .get();
      final items = rows.take(limit).map((r) => map(r.data));
      return Page(
        items: items,
        nextCursor: rows.length > limit
            ? _codec.encode(table, q, rows[limit - 1].read<String>('id'))
            : null,
      );
    });
  }

  @override
  Future<Result<RootDetail>> getRootDetail(String rootId) async {
    try {
      return await database.transaction(() async {
        final roots = await database
            .customSelect(
              'SELECT * FROM roots WHERE id = ?',
              variables: [Variable<String>(rootId)],
            )
            .get();
        if (roots.isEmpty) {
          return const Failure<RootDetail>(
            DomainFailure(FailureKind.notFound, 'root.not_found'),
          );
        }
        const linkedWords =
            "SELECT word_id FROM word_components WHERE component_type = 'root' AND component_id = ?";
        final variables = [Variable<String>(rootId)];
        final words = await database
            .customSelect(
              'SELECT * FROM words WHERE id IN ($linkedWords) ORDER BY id',
              variables: variables,
            )
            .get();
        final components = await database
            .customSelect(
              'SELECT * FROM word_components WHERE word_id IN ($linkedWords) ORDER BY word_id, component_type, component_id, role',
              variables: variables,
            )
            .get();
        final affixes = await database
            .customSelect(
              "SELECT * FROM affixes WHERE id IN (SELECT component_id FROM word_components WHERE component_type = 'affix' AND word_id IN ($linkedWords)) ORDER BY id",
              variables: variables,
            )
            .get();
        final examples = await database
            .customSelect(
              'SELECT * FROM examples WHERE word_id IN ($linkedWords) ORDER BY id',
              variables: variables,
            )
            .get();
        return Success(
          RootDetail(
            root: _mapper.root(roots.single.data),
            words: words.map((r) => _mapper.word(r.data)),
            affixes: affixes.map((r) => _mapper.affix(r.data)),
            components: components
                .map((r) => _mapper.component(r.data))
                .whereType<WordComponent>(),
            examples: examples.map((r) => _mapper.example(r.data)),
          ),
        );
      });
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }

  @override
  Future<Result<Word>> getWord(String id) async {
    try {
      final rows = await database
          .customSelect(
            'SELECT * FROM words WHERE id = ?',
            variables: [Variable<String>(id)],
          )
          .get();
      return rows.isEmpty
          ? const Failure(DomainFailure(FailureKind.notFound, 'word.not_found'))
          : Success(_mapper.word(rows.single.data));
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }

  @override
  Future<Result<WordDetail>> getWordDetail(String id) async {
    try {
      return await database.transaction(() async {
        final variables = [Variable<String>(id)];
        final words = await database
            .customSelect(
              'SELECT * FROM words WHERE id = ?',
              variables: variables,
            )
            .get();
        if (words.isEmpty) {
          return const Failure<WordDetail>(
            DomainFailure(FailureKind.notFound, 'word.not_found'),
          );
        }
        final components = await database
            .customSelect(
              'SELECT * FROM word_components WHERE word_id = ? ORDER BY component_type, component_id, role',
              variables: variables,
            )
            .get();
        final roots = await database
            .customSelect(
              "SELECT * FROM roots WHERE id IN (SELECT component_id FROM word_components WHERE word_id = ? AND component_type = 'root') ORDER BY id",
              variables: variables,
            )
            .get();
        final affixes = await database
            .customSelect(
              "SELECT * FROM affixes WHERE id IN (SELECT component_id FROM word_components WHERE word_id = ? AND component_type = 'affix') ORDER BY id",
              variables: variables,
            )
            .get();
        final examples = await database
            .customSelect(
              'SELECT * FROM examples WHERE word_id = ? ORDER BY id',
              variables: variables,
            )
            .get();
        return Success(
          WordDetail(
            word: _mapper.word(words.single.data),
            roots: roots.map((row) => _mapper.root(row.data)),
            affixes: affixes.map((row) => _mapper.affix(row.data)),
            components: components
                .map((row) => _mapper.component(row.data))
                .whereType<WordComponent>(),
            examples: examples.map((row) => _mapper.example(row.data)),
          ),
        );
      });
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }

  @override
  Future<Result<List<ExampleSentence>>> getExamples(String wordId) async {
    try {
      return await database.transaction(() async {
        final word = await database
            .customSelect(
              'SELECT id FROM words WHERE id = ?',
              variables: [Variable<String>(wordId)],
            )
            .get();
        if (word.isEmpty) {
          return const Failure<List<ExampleSentence>>(
            DomainFailure(FailureKind.notFound, 'word.not_found'),
          );
        }
        final rows = await database
            .customSelect(
              'SELECT * FROM examples WHERE word_id = ? ORDER BY id',
              variables: [Variable<String>(wordId)],
            )
            .get();
        return Success<List<ExampleSentence>>(
          List.unmodifiable(rows.map((r) => _mapper.example(r.data))),
        );
      });
    } catch (_) {
      return const Failure(
        DomainFailure(FailureKind.storage, 'storage.read_failed'),
      );
    }
  }
}
