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
            child: Text(
              '继续学习',
              style: TextStyle(color: FixtureTokens.accent(context)),
            ),
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
      child: session.finished
          ? _summary(context)
          : FixtureScaffold(
              title: '词根学习',
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: session.busy ? null : confirmExit,
                child: Text(
                  '退出',
                  style: TextStyle(color: FixtureTokens.accent(context)),
                ),
              ),
              children: _card(),
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
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                .copyWith(fontWeight: FixtureTypography.headingWeight),
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

  Widget _summary(BuildContext context) {
    final text = FixtureTypography.theme(context).textTheme;
    final link = FixtureTokens.warmLink.resolveFrom(context);
    final canReturn = Navigator.of(context).canPop();
    return CupertinoTheme(
      data: FixtureTypography.theme(context),
      child: CupertinoPageScaffold(
        backgroundColor: FixtureTokens.warmBackground.resolveFrom(context),
        navigationBar: CupertinoNavigationBar(
          middle: const Text('学习总结'),
          border: null,
          backgroundColor: FixtureTokens.warmBackground.resolveFrom(context),
          automaticallyImplyLeading: false,
          leading: canReturn
              ? CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('返回', style: TextStyle(color: link)),
                )
              : null,
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            children: [
              Semantics(
                header: true,
                child: Text(
                  session.abandoned ? '本次学习已结束' : '本组学习已完成',
                  style: text.navLargeTitleTextStyle,
                ),
              ),
              const SizedBox(height: 12),
              Text(widget.rootLabel, style: text.textStyle),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: FixtureTokens.warmSurface.resolveFrom(context),
                  borderRadius: BorderRadius.circular(FixtureTokens.radius),
                ),
                child: Wrap(
                  spacing: 32,
                  runSpacing: 16,
                  children: [
                    _SummaryMetric(label: '本组数量', value: session.total),
                    _SummaryMetric(label: '完成', value: session.completed),
                    _SummaryMetric(label: '跳过', value: session.skipped),
                    if (session.abandoned)
                      _SummaryMetric(
                        label: '尚未完成',
                        value:
                            session.total - session.completed - session.skipped,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '完成包含“知道了”和“需要再学”。',
                style: text.textStyle.copyWith(
                  color: FixtureTokens.secondary(context),
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                liveRegion: true,
                child: Text(
                  '演示内容 · 未接入真实词库\n学习记录不会保存',
                  style: text.textStyle.copyWith(
                    color: link,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                color: FixtureTokens.warmAction.resolveFrom(context),
                onPressed: canReturn ? () => Navigator.of(context).pop() : null,
                child: const Text(
                  '返回词根详情',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FixtureTypography.bodyWeight,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacement<void, void>(
                      FixturePageRoute<void>(
                        context: context,
                        builder: (_) =>
                            FixtureStudyPage(rootLabel: widget.rootLabel),
                      ),
                    ),
                child: Text('再预览一组', style: TextStyle(color: link)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) => Semantics(
    container: true,
    label: '$label：$value',
    child: ExcludeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle
                .copyWith(fontWeight: FixtureTypography.headingWeight),
          ),
          Text(
            label,
            style: TextStyle(
              color: FixtureTokens.secondary(context),
              fontWeight: FixtureTypography.bodyWeight,
            ),
          ),
        ],
      ),
    ),
  );
}
