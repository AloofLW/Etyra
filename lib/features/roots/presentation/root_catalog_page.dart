import 'package:flutter/cupertino.dart' hide Page;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/composition/providers.dart';
import '../../shared/domain/content_types.dart';
import '../../shared/domain/page.dart';
import '../../shared/domain/result.dart';
import '../domain/root.dart';
import 'widgets/fixture_widgets.dart';

final _rootsProvider = FutureProvider.autoDispose<Result<Page<Root>>>(
  (ref) => ref.watch(listRootsProvider)(),
);

final _detailProvider = FutureProvider.autoDispose
    .family<Result<RootDetail>, String>(
      (ref, id) => ref.watch(getRootDetailProvider)(id),
    );

class RootCatalogPage extends ConsumerStatefulWidget {
  const RootCatalogPage({super.key});

  @override
  ConsumerState<RootCatalogPage> createState() => _RootCatalogPageState();
}

class _RootCatalogPageState extends ConsumerState<RootCatalogPage> {
  final List<Root> _additional = [];
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
    ref.invalidate(_rootsProvider);
  }

  Future<void> _loadMore(String cursor) async {
    if (_loadingMore) return;
    final generation = _generation;
    setState(() {
      _loadingMore = true;
      _moreFailed = false;
    });
    try {
      final result = await ref.read(listRootsProvider)(cursor: cursor);
      if (!mounted || generation != _generation) return;
      setState(() {
        _loadingMore = false;
        switch (result) {
          case Success<Page<Root>>(:final value):
            _additional.addAll(value.items);
            _nextCursor = value.nextCursor;
            _hasAdditionalPage = true;
          case Failure<Page<Root>>():
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
  Widget build(BuildContext context) {
    final state = ref.watch(_rootsProvider);
    return FixtureScaffold(
      title: '词根',
      children: state.when(
        skipLoadingOnRefresh: false,
        loading: () => const [_CatalogMessage(title: '正在加载词根', loading: true)],
        error: (_, _) => [_CatalogMessage(title: '词根暂时无法加载', onRetry: _retry)],
        data: (result) => switch (result) {
          Failure<Page<Root>>() => [
            _CatalogMessage(title: '词根暂时无法加载', onRetry: _retry),
          ],
          Success<Page<Root>>(:final value) => _list(value),
        },
      ),
    );
  }

  List<Widget> _list(Page<Root> page) {
    final roots = [...page.items, ..._additional];
    final cursor = _hasAdditionalPage ? _nextCursor : page.nextCursor;
    if (roots.isEmpty && cursor == null) {
      return const [_CatalogMessage(title: '暂无词根内容', message: '本地词库目前为空。')];
    }
    return [
      const FixtureHeading('词根'),
      for (final root in roots)
        FixturePanel(
          children: [
            FixtureHeading(root.displayForm),
            Text(_meaning(root)),
            Text(_verification(root.verificationStatus)),
            FixtureAction(
              label: '查看${root.displayForm}',
              onPressed: () => Navigator.of(context).push<void>(
                FixturePageRoute<void>(
                  context: context,
                  builder: (_) => RootCatalogDetailPage(rootId: root.id),
                ),
              ),
            ),
          ],
        ),
      if (_loadingMore) const _CatalogMessage(title: '正在加载更多', loading: true),
      if (_moreFailed) const Text('加载更多失败，请重试。'),
      if (cursor != null && !_loadingMore)
        FixtureAction(
          label: _moreFailed ? '重试加载更多' : '加载更多',
          onPressed: () => _loadMore(cursor),
        ),
    ];
  }
}

class RootCatalogDetailPage extends ConsumerWidget {
  const RootCatalogDetailPage({super.key, required this.rootId});
  final String rootId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_detailProvider(rootId));
    void retry() => ref.invalidate(_detailProvider(rootId));
    return FixtureScaffold(
      title: '词根详情',
      children: state.when(
        skipLoadingOnRefresh: false,
        loading: () => const [
          _CatalogMessage(title: '正在加载词根详情', loading: true),
        ],
        error: (_, _) => [_CatalogMessage(title: '词根详情暂时无法加载', onRetry: retry)],
        data: (result) => switch (result) {
          Failure<RootDetail>(:final error)
              when error.kind == FailureKind.notFound =>
            [
              _CatalogMessage(
                title: '未找到该词根',
                message: '内容可能已被移除。',
                onRetry: retry,
              ),
            ],
          Failure<RootDetail>() => [
            _CatalogMessage(title: '词根详情暂时无法加载', onRetry: retry),
          ],
          Success<RootDetail>(:final value) => _detail(context, value),
        },
      ),
    );
  }

  List<Widget> _detail(BuildContext context, RootDetail detail) {
    final root = detail.root;
    return [
      Semantics(
        header: true,
        child: Text(
          root.displayForm,
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
              .copyWith(fontWeight: FixtureTypography.headingWeight),
        ),
      ),
      Text(_meaning(root)),
      Text(_verification(root.verificationStatus)),
      if (root.verificationStatus == VerificationStatus.verified &&
          root.originNote != null &&
          root.originNote!.trim().isNotEmpty)
        Text(root.originNote!),
      const FixtureHeading('来源'),
      if (root.sources.isEmpty)
        const Text('暂无可追溯来源。')
      else
        for (final source in root.sources)
          Text(
            [
              source.title,
              if (source.publisher != null && source.publisher!.isNotEmpty)
                source.publisher!,
              if (source.edition != null && source.edition!.isNotEmpty)
                source.edition!,
              if (source.locator != null && source.locator!.isNotEmpty)
                source.locator!,
              if (source.url != null && source.url!.isNotEmpty) source.url!,
              if (source.licenseName != null && source.licenseName!.isNotEmpty)
                source.licenseName!,
              if (source.licenseUrl != null && source.licenseUrl!.isNotEmpty)
                source.licenseUrl!,
              if (source.attributionText != null &&
                  source.attributionText!.isNotEmpty)
                source.attributionText!,
            ].join(' · '),
          ),
      const FixtureHeading('构词关系'),
      if (detail.affixes.isEmpty)
        const Text('暂无关联词缀。')
      else
        for (final affix in detail.affixes)
          Text('${affix.form} · ${_verification(affix.verificationStatus)}'),
      const FixtureHeading('关联单词'),
      if (detail.words.isEmpty)
        const Text('暂无关联单词。')
      else ...[
        const Text('关联关系尚需核验。'),
        for (final word in detail.words) Text(word.word),
      ],
      const Text('真实词根学习尚未接入。'),
    ];
  }
}

String _verification(VerificationStatus status) => switch (status) {
  VerificationStatus.verified => '已核验',
  VerificationStatus.unverified => '待核验',
  VerificationStatus.disputed => '存在争议，待核验',
};

String _meaning(Root root) => switch (root.verificationStatus) {
  VerificationStatus.verified => root.meaning,
  VerificationStatus.unverified => '释义待核验：${root.meaning}',
  VerificationStatus.disputed => '释义存在争议：${root.meaning}',
};

class _CatalogMessage extends StatelessWidget {
  const _CatalogMessage({
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
