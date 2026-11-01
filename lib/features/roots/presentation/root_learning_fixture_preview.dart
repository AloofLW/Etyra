import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

import 'fixtures/root_learning_fixture.dart';
import 'root_learning_pages.dart';
import 'widgets/fixture_widgets.dart';

/// Learner-facing entry point; the preview tools remain available separately.
class RootLearningFixturePreview extends StatelessWidget {
  const RootLearningFixturePreview({super.key});

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      backgroundColor: FixtureTokens.background(context),
      activeColor: FixtureTokens.accent(context),
      inactiveColor: FixtureTokens.secondary(context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: '学习'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_tree_outlined),
          label: '词根',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: '单词',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: '设置',
        ),
      ],
    ),
    tabBuilder: (context, index) => switch (index) {
      0 => const _LearnerHome(),
      1 => const RootFixtureListPage(),
      2 => const _UnavailablePage(title: '单词', message: '单词浏览尚未接入。'),
      _ => const _UnavailablePage(title: '设置', message: '设置功能尚未接入。'),
    },
  );
}

class _UnavailablePage extends StatelessWidget {
  const _UnavailablePage({required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: title,
    children: [
      const FixtureContentNotice(),
      FixtureHeading(title),
      Text(message),
    ],
  );
}

class _LearnerHome extends StatelessWidget {
  const _LearnerHome();

  @override
  Widget build(BuildContext context) {
    final text = CupertinoTheme.of(context).textTheme;
    return CupertinoPageScaffold(
      backgroundColor: FixtureTokens.background(context),
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: FixtureTokens.background(context),
        automaticallyImplyLeading: false,
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
            style: TextStyle(color: FixtureTokens.accent(context)),
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
              color: FixtureTokens.warmAction.resolveFrom(context),
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
                  style: TextStyle(color: FixtureTokens.accent(context)),
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
                activeTrackColor: FixtureTokens.warmAction.resolveFrom(context),
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
                  child: Text(
                    '查看列表',
                    style: TextStyle(color: FixtureTokens.accent(context)),
                  ),
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
                  child: Text(
                    '查看详情',
                    style: TextStyle(color: FixtureTokens.accent(context)),
                  ),
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
