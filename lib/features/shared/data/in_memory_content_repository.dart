import '../../roots/domain/root.dart';
import '../../roots/domain/root_repository.dart';
import '../../words/domain/word.dart';
import '../../words/domain/word_repository.dart';
import '../domain/content_types.dart';
import '../domain/page.dart';
import '../domain/result.dart';
import 'cursor_codec.dart';

/// Explicitly ephemeral fake for presentation development. No built-in content.
final class InMemoryContentRepository
    implements RootRepository, WordRepository {
  InMemoryContentRepository({
    Iterable<Root> roots = const [],
    Iterable<Affix> affixes = const [],
    Iterable<Word> words = const [],
    Iterable<WordComponent> components = const [],
    Iterable<ExampleSentence> examples = const [],
  }) : roots = List.unmodifiable(roots),
       affixes = List.unmodifiable(affixes),
       words = List.unmodifiable(words),
       components = List.unmodifiable(components),
       examples = List.unmodifiable(examples);
  final List<Root> roots;
  final List<Affix> affixes;
  final List<Word> words;
  final List<WordComponent> components;
  final List<ExampleSentence> examples;
  static const _codec = CursorCodec();

  @override
  Future<Result<Page<Root>>> listRoots({
    String? query,
    String? cursor,
    int limit = 30,
  }) async {
    final q = (query ?? '').trim().toLowerCase();
    return _page(
      roots.where(
        (r) => '${r.lemma} ${r.displayForm} ${r.meaning}'
            .toLowerCase()
            .contains(q),
      ),
      (r) => r.id,
      'roots',
      q,
      cursor,
      limit,
    );
  }

  @override
  Future<Result<Page<Word>>> listWords({
    String? query,
    String? cursor,
    int limit = 30,
  }) async {
    final q = (query ?? '').trim().toLowerCase();
    return _page(
      words.where(
        (w) => '${w.word} ${w.normalizedWord} ${w.definition}'
            .toLowerCase()
            .contains(q),
      ),
      (w) => w.id,
      'words',
      q,
      cursor,
      limit,
    );
  }

  Result<Page<T>> _page<T>(
    Iterable<T> values,
    String Function(T) id,
    String scope,
    String query,
    String? cursor,
    int limit,
  ) {
    if (limit <= 0) {
      return const Failure(
        DomainFailure(FailureKind.validation, 'pagination.invalid_limit'),
      );
    }
    try {
      final after = _codec.decode(cursor, scope, query);
      final items =
          values
              .where((v) => after == null || id(v).compareTo(after) > 0)
              .toList()
            ..sort((a, b) => id(a).compareTo(id(b)));
      final page = items.take(limit).toList();
      return Success(
        Page(
          items: page,
          nextCursor: items.length > limit
              ? _codec.encode(scope, query, id(page.last))
              : null,
        ),
      );
    } on FormatException {
      return const Failure(
        DomainFailure(FailureKind.validation, 'pagination.invalid_cursor'),
      );
    }
  }

  @override
  Future<Result<RootDetail>> getRootDetail(String rootId) async {
    final matches = roots.where((r) => r.id == rootId);
    if (matches.isEmpty) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'root.not_found'),
      );
    }
    final wordIds = components
        .where(
          (c) =>
              c.componentType == ComponentType.root && c.componentId == rootId,
        )
        .map((c) => c.wordId)
        .toSet();
    final related = components
        .where((c) => wordIds.contains(c.wordId))
        .toList();
    final affixIds = related
        .where((c) => c.componentType == ComponentType.affix)
        .map((c) => c.componentId)
        .toSet();
    return Success(
      RootDetail(
        root: matches.first,
        words: words.where((w) => wordIds.contains(w.id)),
        affixes: affixes.where((a) => affixIds.contains(a.id)),
        components: related,
        examples: examples.where((e) => wordIds.contains(e.wordId)),
      ),
    );
  }

  @override
  Future<Result<Word>> getWord(String id) async {
    final matches = words.where((w) => w.id == id);
    return matches.isEmpty
        ? const Failure(DomainFailure(FailureKind.notFound, 'word.not_found'))
        : Success(matches.first);
  }

  @override
  Future<Result<List<ExampleSentence>>> getExamples(String wordId) async {
    if (!words.any((w) => w.id == wordId)) {
      return const Failure(
        DomainFailure(FailureKind.notFound, 'word.not_found'),
      );
    }
    return Success(
      List.unmodifiable(examples.where((e) => e.wordId == wordId)),
    );
  }
}
