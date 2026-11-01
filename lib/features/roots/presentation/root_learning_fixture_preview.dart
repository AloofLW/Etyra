import 'package:flutter/cupertino.dart';

import 'fixtures/root_learning_fixture.dart';
import 'root_learning_pages.dart';
import 'widgets/fixture_widgets.dart';

abstract final class _HomeColors {
  static const background = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFAF6EF),
    darkColor: Color(0xFF1C1917),
  );
  static const action = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFA04A38),
    darkColor: Color(0xFF9A4535),
  );
  static const link = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF91412F),
    darkColor: Color(0xFFEEAB96),
  );
}

/// Learner-facing entry point; the preview tools remain available separately.
class RootLearningFixturePreview extends StatelessWidget {
  const RootLearningFixturePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final text = CupertinoTheme.of(context).textTheme;
    return CupertinoPageScaffold(
      backgroundColor: _HomeColors.background.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: _HomeColors.background.resolveFrom(context),
        middle: const Text('Etyra'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).push<void>(
            FixturePageRoute<void>(
              context: context,
              builder: (_) => const _PreviewToolsPage(),
            ),
          ),
          child: Text(
            '预览工具',
            style: TextStyle(color: _HomeColors.link.resolveFrom(context)),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            Semantics(
              header: true,
              child: Text(
                '从词根开始，\n理解单词。',
                style: text.navLargeTitleTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              color: _HomeColors.action.resolveFrom(context),
              onPressed: () => Navigator.of(context).push<void>(
                FixturePageRoute<void>(
                  context: context,
                  builder: (_) => RootFixtureDetailPage(
                    root: RootLearningFixture.samples.first,
                  ),
                ),
              ),
              child: const Text(
                '开始学习演示',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '演示内容 · 尚未接入真实词库，学习记录不会保存。',
              style: text.textStyle.copyWith(
                color: FixtureTokens.secondary(context),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).push<void>(
                  FixturePageRoute<void>(
                    context: context,
                    builder: (_) => const RootFixtureListPage(),
                  ),
                ),
                child: Text(
                  '浏览演示词根  ›',
                  style: TextStyle(
                    color: _HomeColors.link.resolveFrom(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewToolsPage extends StatefulWidget {
  const _PreviewToolsPage();

  @override
  State<_PreviewToolsPage> createState() => _PreviewToolsPageState();
}

class _PreviewToolsPageState extends State<_PreviewToolsPage> {
  bool failNextWrite = false;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '预览工具',
    children: [
      const Text('演示不同页面状态；重新加载后显示演示内容。'),
      CupertinoListSection.insetGrouped(
        margin: EdgeInsets.zero,
        children: [
          CupertinoListTile(
            title: const Text('模拟首次提交失败'),
            trailing: Semantics(
              label: '模拟首次提交失败',
              child: CupertinoSwitch(
                value: failNextWrite,
                onChanged: (value) => setState(() => failNextWrite = value),
              ),
            ),
          ),
        ],
      ),
      for (final phase in FixturePhase.values)
        FixturePanel(
          children: [
            FixtureHeading(_phaseLabel(phase)),
            Wrap(
              spacing: 12,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => RootFixtureListPage(
                        initialPhase: phase,
                        failNextWrite: failNextWrite,
                      ),
                    ),
                  ),
                  child: const Text('查看列表'),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => RootFixtureDetailPage(
                        root: RootLearningFixture.samples.first,
                        initialPhase: phase,
                        failNextWrite: failNextWrite,
                      ),
                    ),
                  ),
                  child: const Text('查看详情'),
                ),
              ],
            ),
          ],
        ),
    ],
  );

  String _phaseLabel(FixturePhase phase) => switch (phase) {
    FixturePhase.initial => '尚未加载',
    FixturePhase.loading => '加载中',
    FixturePhase.data => '正常内容',
    FixturePhase.empty => '暂无内容',
    FixturePhase.error => '加载失败',
  };
}
