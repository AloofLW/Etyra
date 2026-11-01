import 'package:flutter/cupertino.dart';

import '../../roots/presentation/fixtures/root_learning_fixture.dart';
import '../../roots/presentation/widgets/fixture_widgets.dart';

class FixtureStudyPage extends StatefulWidget {
  const FixtureStudyPage({
    super.key,
    required this.rootLabel,
    this.failNextWrite = false,
  });
  final String rootLabel;
  final bool failNextWrite;

  @override
  State<FixtureStudyPage> createState() => _FixtureStudyState();
}

class _FixtureStudyState extends State<FixtureStudyPage> {
  late final FixtureSessionController session;
  bool showingExit = false;

  @override
  void initState() {
    super.initState();
    session = FixtureSessionController(failNextWrite: widget.failNextWrite);
  }

  @override
  void dispose() {
    session.dispose();
    super.dispose();
  }

  Future<void> confirmExit() async {
    if (showingExit || session.busy || session.finished) return;
    showingExit = true;
    final shouldExit = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('结束本次学习？'),
        content: const Text('已提交的反馈会保留在本次预览总结中。退出后不能继续本次学习；预览不会写入正式学习记录。'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('继续学习'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('结束学习'),
          ),
        ],
      ),
    );
    showingExit = false;
    if (mounted && shouldExit == true) session.abandon();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: session,
    builder: (context, _) => PopScope(
      canPop: session.finished,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) confirmExit();
      },
      child: FixtureScaffold(
        title: session.finished ? '学习总结' : '词根学习',
        leading: session.finished
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: session.busy ? null : confirmExit,
                child: const Text('退出'),
              ),
        children: session.finished ? _summary(context) : _card(),
      ),
    ),
  );

  List<Widget> _card() => [
    const FixtureContentNotice(),
    Semantics(
      liveRegion: true,
      label:
          '第 ${session.position + 1} 项，共 ${session.total} 项，'
          '已完成 ${session.completed} 项，跳过 ${session.skipped} 项',
      child: ExcludeSemantics(
        child: Text(
          '第 ${session.position + 1} / ${session.total} 项 · '
          '完成 ${session.completed} · 跳过 ${session.skipped}',
        ),
      ),
    ),
    ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          height: 4,
          color: CupertinoColors.systemGrey5.resolveFrom(context),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: (session.position + 1) / session.total,
            child: Container(color: FixtureTokens.accent(context)),
          ),
        ),
      ),
    ),
    FixturePanel(
      children: [
        Semantics(
          header: true,
          child: Text(
            widget.rootLabel,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
        Text('回忆提示占位 ${session.position + 1}'),
        const Text('内容待核验 · 未提供真实词源或释义'),
        if (session.revealed) ...[
          const FixtureHeading('答案与解释'),
          const Text('审核后的释义与构词解释将在这里呈现。'),
        ] else
          const Text('先在心里回忆，再查看答案。'),
      ],
    ),
    if (session.error != null)
      Semantics(
        liveRegion: true,
        child: FixturePanel(
          children: [
            Text(session.error!),
            const Text('当前位置和计数未改变，可再次选择原操作重试。'),
          ],
        ),
      ),
    if (session.busy) Semantics(liveRegion: true, child: const Text('正在提交反馈…')),
    if (session.feedback != null) ...[
      Semantics(
        liveRegion: true,
        child: FixturePanel(
          children: [
            const FixtureHeading('本次反馈'),
            Text(switch (session.feedback!) {
              FixtureFeedback.recalled => '已标记“知道了”。这表示本次回忆反馈，不代表长期掌握。',
              FixtureFeedback.needsPractice => '已标记“需要再学”。',
              FixtureFeedback.skipped => '已跳过。本项不计入完成数。',
            }),
          ],
        ),
      ),
      FixtureAction(
        label: session.position + 1 == session.total ? '查看总结' : '下一项',
        primary: true,
        onPressed: session.next,
      ),
    ] else ...[
      if (!session.revealed)
        FixtureAction(
          label: '显示答案',
          primary: true,
          onPressed: session.busy ? null : session.reveal,
        )
      else ...[
        FixtureAction(
          label: '知道了',
          primary: true,
          onPressed: session.busy
              ? null
              : () => session.submit(FixtureFeedback.recalled),
        ),
        FixtureAction(
          label: '需要再学',
          onPressed: session.busy
              ? null
              : () => session.submit(FixtureFeedback.needsPractice),
        ),
      ],
      FixtureAction(
        label: '跳过本项',
        onPressed: session.busy
            ? null
            : () => session.submit(FixtureFeedback.skipped),
      ),
    ],
  ];

  List<Widget> _summary(BuildContext context) => [
    const FixtureContentNotice(),
    FixturePanel(
      children: [
        FixtureHeading(session.abandoned ? '本次学习已结束' : '本组学习已完成'),
        Text('本组数量：${session.total}'),
        Text('完成：${session.completed}'),
        Text('跳过：${session.skipped}'),
        Text('尚未完成：${session.total - session.completed - session.skipped}'),
        const Text('完成数包含“知道了”和“需要再学”，不表示答对数量或长期掌握。'),
      ],
    ),
    FixtureAction(
      label: '返回词根详情',
      primary: true,
      onPressed: () => Navigator.of(context).pop(),
    ),
    FixtureAction(
      label: '再预览一组',
      onPressed: () => Navigator.of(context).pushReplacement<void, void>(
        FixturePageRoute<void>(
          context: context,
          builder: (_) => FixtureStudyPage(rootLabel: widget.rootLabel),
        ),
      ),
    ),
  ];
}
