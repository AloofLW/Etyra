import 'package:flutter/cupertino.dart' hide Page;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/composition/providers.dart';
import '../../roots/presentation/widgets/fixture_widgets.dart';
import '../../shared/domain/content_types.dart';
import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import '../../shared/domain/source_ref.dart';
import '../domain/word.dart';
import '../domain/word_detail.dart';

final _wordsProvider = FutureProvider.autoDispose<Result<Page<Word>>>(
  (ref) => ref.watch(listWordsProvider)(),
);
final _wordDetailProvider = FutureProvider.autoDispose
    .family<Result<WordDetail>, String>(
      (ref, id) => ref.watch(getWordDetailProvider)(id),
    );

/// Real local catalog; this page never falls back to demonstration content.
class WordCatalogPage extends ConsumerStatefulWidget {
  const WordCatalogPage({super.key});

  @override
  ConsumerState<WordCatalogPage> createState() => _WordCatalogPageState();
}

class _WordCatalogPageState extends ConsumerState<WordCatalogPage> {
  final _additional = <Word>[];
  String? _nextCursor;
  bool _hasAdditionalPage = false;
  bool _loadingMore = false;
  bool _moreFailed = false;
  int _generation = 0;

  void _retry() {
    setState(() {
      _generation++;
      _additional.clear();
      _nextCursor = null;
      _hasAdditionalPage = false;
      _loadingMore = false;
      _moreFailed = false;
    });
    ref.invalidate(_wordsProvider);
  }

  Future<void> _loadMore(String cursor) async {
    if (_loadingMore) return;
    final generation = _generation;
    setState(() {
      _loadingMore = true;
      _moreFailed = false;
    });
    try {
      final result = await ref.read(listWordsProvider)(cursor: cursor);
      if (!mounted || generation != _generation) return;
      setState(() {
        _loadingMore = false;
        switch (result) {
          case Success<Page<Word>>(:final value):
            _additional.addAll(value.items);
            _nextCursor = value.nextCursor;
            _hasAdditionalPage = true;
          case Failure<Page<Word>>():
            _moreFailed = true;
        }
      });
    } catch (_) {
      if (!mounted || generation != _generation) return;
      setState(() {
        _loadingMore = false;
        _moreFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '单词',
    children: ref
        .watch(_wordsProvider)
        .when(
          skipLoadingOnRefresh: false,
          loading: () => const [_WordMessage(title: '正在加载单词', loading: true)],
          error: (_, _) => [_WordMessage(title: '单词暂时无法加载', onRetry: _retry)],
          data: (result) => switch (result) {
            Failure<Page<Word>>() => [
              _WordMessage(title: '单词暂时无法加载', onRetry: _retry),
            ],
            Success<Page<Word>>(:final value) => _list(value),
          },
        ),
  );

  List<Widget> _list(Page<Word> page) {
    final words = [...page.items, ..._additional];
    final cursor = _hasAdditionalPage ? _nextCursor : page.nextCursor;
    if (words.isEmpty && cursor == null) {
      return const [_WordMessage(title: '暂无单词内容', message: '本地词库目前为空。')];
    }
    return [
      const FixtureHeading('单词'),
      for (final word in words)
        FixturePanel(
          children: [
            FixtureHeading(word.word),
            Text(word.definition),
            FixtureAction(
              label: '查看${word.word}',
              onPressed: () => Navigator.of(context).push<void>(
                FixturePageRoute<void>(
                  context: context,
                  builder: (_) => WordCatalogDetailPage(wordId: word.id),
                ),
              ),
            ),
          ],
        ),
      if (_loadingMore) const _WordMessage(title: '正在加载更多', loading: true),
      if (_moreFailed) const Text('加载更多失败，请重试。'),
      if (cursor != null && !_loadingMore)
        FixtureAction(
          label: _moreFailed ? '重试加载更多' : '加载更多',
          onPressed: () => _loadMore(cursor),
        ),
    ];
  }
}

class WordCatalogDetailPage extends ConsumerWidget {
  const WordCatalogDetailPage({super.key, required this.wordId});
  final String wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void retry() => ref.invalidate(_wordDetailProvider(wordId));
    return FixtureScaffold(
      title: '单词详情',
      children: ref
          .watch(_wordDetailProvider(wordId))
          .when(
            skipLoadingOnRefresh: false,
            loading: () => const [
              _WordMessage(title: '正在加载单词详情', loading: true),
            ],
            error: (_, _) => [
              _WordMessage(title: '单词详情暂时无法加载', onRetry: retry),
            ],
            data: (result) => switch (result) {
              Failure<WordDetail>(:final error)
                  when error.kind == FailureKind.notFound =>
                [
                  _WordMessage(
                    title: '未找到该单词',
                    message: '内容可能已被移除。',
                    onRetry: retry,
                  ),
                ],
              Failure<WordDetail>() => [
                _WordMessage(title: '单词详情暂时无法加载', onRetry: retry),
              ],
              Success<WordDetail>(:final value) => _detail(context, value),
            },
          ),
    );
  }

  List<Widget> _detail(BuildContext context, WordDetail detail) {
    final word = detail.word;
    final components = detail.components
        .where((item) => item.wordId == word.id)
        .toList();
    return [
      Semantics(
        header: true,
        child: Text(
          word.word,
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
              .copyWith(fontWeight: FixtureTypography.headingWeight),
        ),
      ),
      if (_hasText(word.partOfSpeech)) Text(word.partOfSpeech!),
      Text(word.definition),
      if (_hasText(word.translation)) Text(word.translation!),
      const FixtureHeading('单词来源'),
      ..._sources(word.sources),
      const FixtureHeading('构词关系'),
      if (components.isEmpty)
        const Text('暂无明确的构词关系。')
      else ...[
        const Text('仅展示已记录的关系，关系仍需核验。'),
        for (final component in components) ...[
          Text(_componentLabel(detail, component)),
          Text(
            '角色：${_role(component.role)} · ${_confidence(component.confidence)}',
          ),
          ..._sources(component.sources, missing: '关系暂无来源。'),
        ],
      ],
      const FixtureHeading('例句'),
      if (detail.examples.isEmpty)
        const Text('暂无例句。')
      else
        for (final example in detail.examples) ...[
          Text(example.sentence),
          if (_hasText(example.translation)) Text(example.translation!),
          ..._sources(example.sources, missing: '例句暂无来源。'),
        ],
    ];
  }
}

String _componentLabel(WordDetail detail, WordComponent component) {
  switch (component.componentType) {
    case ComponentType.root:
      final roots = detail.roots.where(
        (item) => item.id == component.componentId,
      );
      if (roots.isEmpty) return '关联词根不可用';
      final root = roots.first;
      return '词根：${root.displayForm} · ${_verification(root.verificationStatus)}';
    case ComponentType.affix:
      final affixes = detail.affixes.where(
        (item) => item.id == component.componentId,
      );
      if (affixes.isEmpty) return '关联词缀不可用';
      final affix = affixes.first;
      return '词缀：${affix.form} · ${_verification(affix.verificationStatus)}';
  }
}

String _verification(VerificationStatus status) => switch (status) {
  VerificationStatus.verified => '内容已核验',
  VerificationStatus.unverified => '内容待核验',
  VerificationStatus.disputed => '内容存在争议',
};

String _role(ComponentRole role) => switch (role) {
  ComponentRole.root => '词根',
  ComponentRole.prefix => '前缀',
  ComponentRole.suffix => '后缀',
  ComponentRole.other => '其他',
  ComponentRole.unknown => '未知',
};

String _confidence(double? value) =>
    value == null || !value.isFinite || value < 0 || value > 1
    ? '未提供有效置信度'
    : '记录置信度 ${(value * 100).toStringAsFixed(0)}%（不代表已核验）';

bool _hasText(String? value) => value != null && value.trim().isNotEmpty;

List<Widget> _sources(List<SourceRef> sources, {String missing = '暂无可追溯来源。'}) =>
    [
      if (sources.isEmpty)
        Text(missing)
      else
        for (final source in sources)
          Text(
            [
              source.title,
              if (_hasText(source.publisher)) source.publisher!,
              if (_hasText(source.edition)) source.edition!,
              if (_hasText(source.locator)) source.locator!,
              if (_hasText(source.url)) source.url!,
              if (_hasText(source.licenseName)) source.licenseName!,
              if (_hasText(source.licenseUrl)) source.licenseUrl!,
              if (_hasText(source.attributionText)) source.attributionText!,
            ].join(' · '),
          ),
    ];

class _WordMessage extends StatelessWidget {
  const _WordMessage({
    required this.title,
    this.message,
    this.loading = false,
    this.onRetry,
  });
  final String title;
  final String? message;
  final bool loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => FixturePanel(
    children: [
      if (loading && !MediaQuery.disableAnimationsOf(context))
        const ExcludeSemantics(child: CupertinoActivityIndicator()),
      Semantics(liveRegion: true, child: FixtureHeading(title)),
      if (message != null) Text(message!),
      if (onRetry != null)
        FixtureAction(label: '重试', onPressed: onRetry, primary: true),
    ],
  );
}
