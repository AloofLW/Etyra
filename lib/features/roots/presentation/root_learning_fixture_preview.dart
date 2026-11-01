import 'package:flutter/cupertino.dart';

import 'fixtures/root_learning_fixture.dart';
import 'root_learning_pages.dart';
import 'widgets/fixture_widgets.dart';

/// Learner-facing entry point; the preview tools remain available separately.
class RootLearningFixturePreview extends StatelessWidget {
  const RootLearningFixturePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final text = CupertinoTheme.of(context).textTheme;
    return CupertinoPageScaffold(
      backgroundColor: FixtureTokens.background(context),
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: FixtureTokens.background(context),
        middle: const Text('Etyra'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).push<void>(
            FixturePageRoute<void>(
              context: context,
              builder: (_) => const _PreviewToolsPage(),
            ),
          ),
          child: const Text('预览工具'),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
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
            const SizedBox(height: 12),
            Text(
              '认识构词成分，探索它与单词的联系。',
              style: text.textStyle.copyWith(
                color: FixtureTokens.secondary(context),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            FixturePanel(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: FixtureTokens.accentBackground(context),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: ExcludeSemantics(
                          child: Text(
                            '根',
                            style: text.navTitleTextStyle.copyWith(
                              color: FixtureTokens.accent(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('词根学习', style: text.navTitleTextStyle),
                          const SizedBox(height: 5),
                          Text(
                            '从一个词根出发，看看学习过程。',
                            style: text.textStyle.copyWith(
                              color: FixtureTokens.secondary(context),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FixtureAction(
                  label: '开始学习演示',
                  primary: true,
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => RootFixtureDetailPage(
                        root: RootLearningFixture.samples.first,
                      ),
                    ),
                  ),
                ),
              ],
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
                child: const Text('浏览演示词根  ›'),
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
