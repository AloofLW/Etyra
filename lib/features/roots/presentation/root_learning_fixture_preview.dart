import 'package:flutter/cupertino.dart';

import 'fixtures/root_learning_fixture.dart';
import 'root_learning_pages.dart';
import 'widgets/fixture_widgets.dart';

/// Opt-in preview entry point. Mount under an existing CupertinoApp/Navigator.
/// It is intentionally not registered in the production app.
class RootLearningFixturePreview extends StatefulWidget {
  const RootLearningFixturePreview({super.key});

  @override
  State<RootLearningFixturePreview> createState() => _PreviewState();
}

class _PreviewState extends State<RootLearningFixturePreview> {
  bool failNextWrite = false;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '词根学习界面预览',
    children: [
      const FixtureContentNotice(),
      const Text('选择列表或详情的首屏状态。重新加载后进入正常占位内容。'),
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
            FixtureAction(
              label: '查看列表',
              onPressed: () => Navigator.of(context).push<void>(
                FixturePageRoute<void>(
                  context: context,
                  builder: (_) => RootFixtureListPage(
                    initialPhase: phase,
                    failNextWrite: failNextWrite,
                  ),
                ),
              ),
            ),
            FixtureAction(
              label: '查看详情',
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
