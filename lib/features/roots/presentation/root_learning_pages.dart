import 'package:flutter/cupertino.dart';

import '../../study/presentation/fixture_study_page.dart';
import 'fixtures/root_learning_fixture.dart';
import 'widgets/fixture_widgets.dart';

/// Local-only loading simulation, shared by list and detail previews.
mixin _FixtureLoading<T extends StatefulWidget> on State<T> {
  late FixturePhase phase;

  void initializePhase(FixturePhase initial) {
    phase = initial;
    if (initial == FixturePhase.loading) _completeLoad();
  }

  Future<void> load() async {
    setState(() => phase = FixturePhase.loading);
    await _completeLoad();
  }

  Future<void> _completeLoad() async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (mounted) setState(() => phase = FixturePhase.data);
  }
}

class RootFixtureListPage extends StatefulWidget {
  const RootFixtureListPage({
    super.key,
    this.initialPhase = FixturePhase.data,
    this.failNextWrite = false,
  });
  final FixturePhase initialPhase;
  final bool failNextWrite;

  @override
  State<RootFixtureListPage> createState() => _RootListState();
}

class _RootListState extends State<RootFixtureListPage>
    with _FixtureLoading<RootFixtureListPage> {
  @override
  void initState() {
    super.initState();
    initializePhase(widget.initialPhase);
  }

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '词根',
    children: [
      const FixtureContentNotice(),
      if (phase != FixturePhase.data)
        FixtureStateView(phase: phase, onRetry: load)
      else ...[
        FixturePanel(
          children: [
            const FixtureHeading('选择词根'),
            for (final root in RootLearningFixture.samples) ...[
              if (root != RootLearningFixture.samples.first)
                const SizedBox(height: 4),
              FixtureHeading(root.label),
              const Text('释义待接入审核内容'),
              const Text('演示占位 · 来源待核验'),
              FixtureAction(
                label: '查看${root.label}',
                onPressed: () => Navigator.of(context).push<void>(
                  FixturePageRoute<void>(
                    context: context,
                    builder: (_) => RootFixtureDetailPage(
                      root: root,
                      failNextWrite: widget.failNextWrite,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        const Text('已显示全部预览内容'),
      ],
    ],
  );
}

class RootFixtureDetailPage extends StatefulWidget {
  const RootFixtureDetailPage({
    super.key,
    required this.root,
    this.initialPhase = FixturePhase.data,
    this.failNextWrite = false,
  });
  final RootLearningFixture root;
  final FixturePhase initialPhase;
  final bool failNextWrite;

  @override
  State<RootFixtureDetailPage> createState() => _RootDetailState();
}

class _RootDetailState extends State<RootFixtureDetailPage>
    with _FixtureLoading<RootFixtureDetailPage> {
  @override
  void initState() {
    super.initState();
    initializePhase(widget.initialPhase);
  }

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '词根详情',
    children: [
      const FixtureContentNotice(),
      if (phase != FixturePhase.data)
        FixtureStateView(phase: phase, onRetry: load)
      else ...[
        FixturePanel(
          children: [
            FixtureHeading(widget.root.label),
            const Text('释义待接入审核内容'),
            const Text('尚无可追溯来源 · 待核验'),
            const SizedBox(height: 4),
            const FixtureHeading('构词关系'),
            const Text('暂无已审核的词根、词缀关系。'),
            const SizedBox(height: 4),
            const FixtureHeading('关联单词'),
            if (widget.root.words.isEmpty)
              const Text('暂无关联单词。仍可预览词根学习流程。')
            else
              for (final word in widget.root.words)
                FixtureAction(
                  label: '查看$word',
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => _RelatedWordPreview(word: word),
                    ),
                  ),
                ),
          ],
        ),
        FixtureAction(
          label: '开始词根学习',
          primary: true,
          onPressed: () => Navigator.of(context).push<void>(
            FixturePageRoute<void>(
              context: context,
              builder: (_) => _StudyIntroduction(
                root: widget.root,
                failNextWrite: widget.failNextWrite,
              ),
            ),
          ),
        ),
      ],
    ],
  );
}

class _RelatedWordPreview extends StatelessWidget {
  const _RelatedWordPreview({required this.word});
  final String word;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '关联单词',
    children: [
      const FixtureContentNotice(),
      FixturePanel(
        children: [
          FixtureHeading(word),
          const Text('词性、释义、构词拆解和来源待接入。'),
          const Text('暂无已审核例句。'),
          const Text('发音暂不可用'),
        ],
      ),
    ],
  );
}

class _StudyIntroduction extends StatelessWidget {
  const _StudyIntroduction({required this.root, required this.failNextWrite});
  final RootLearningFixture root;
  final bool failNextWrite;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '学习说明',
    children: [
      const FixtureContentNotice(),
      FixturePanel(
        children: [
          FixtureHeading(root.label),
          const Text('先尝试回忆，再查看答案，最后选择“知道了”或“需要再学”。也可以跳过。'),
          const Text('本次使用 2 张占位卡片演示交互，不代表实际学习队列。'),
        ],
      ),
      FixtureAction(
        label: '开始预览',
        primary: true,
        onPressed: () => Navigator.of(context).pushReplacement<void, void>(
          FixturePageRoute<void>(
            context: context,
            builder: (_) => FixtureStudyPage(
              rootLabel: root.label,
              failNextWrite: failNextWrite,
            ),
          ),
        ),
      ),
    ],
  );
}
