import 'package:flutter/cupertino.dart';

import '../fixtures/root_learning_fixture.dart';

class FixturePageRoute<T> extends CupertinoPageRoute<T> {
  FixturePageRoute({required BuildContext context, required super.builder})
    : reduceMotion = MediaQuery.disableAnimationsOf(context);

  final bool reduceMotion;

  @override
  Duration get transitionDuration =>
      reduceMotion ? Duration.zero : super.transitionDuration;

  @override
  Duration get reverseTransitionDuration =>
      reduceMotion ? Duration.zero : super.reverseTransitionDuration;
}

abstract final class FixtureTokens {
  static const gap = 16.0;
  static const radius = 16.0;
  static const touchTarget = 44.0;
  static const _accent = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF416D66),
    darkColor: Color(0xFF9CCDC1),
  );
  static const _accentBackground = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFE1EFEB),
    darkColor: Color(0xFF233D39),
  );
  static Color accent(BuildContext context) => _accent.resolveFrom(context);
  static Color accentBackground(BuildContext context) =>
      _accentBackground.resolveFrom(context);
  static Color background(BuildContext context) =>
      CupertinoColors.systemGroupedBackground.resolveFrom(context);
  static Color surface(BuildContext context) =>
      CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context);
  static Color secondary(BuildContext context) =>
      CupertinoColors.secondaryLabel.resolveFrom(context);
}

class FixtureScaffold extends StatelessWidget {
  const FixtureScaffold({
    super.key,
    required this.title,
    required this.children,
    this.leading,
  });

  final String title;
  final List<Widget> children;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    backgroundColor: FixtureTokens.background(context),
    navigationBar: CupertinoNavigationBar(
      middle: Text(title),
      leading: leading,
    ),
    child: SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(FixtureTokens.gap),
        itemCount: children.length,
        separatorBuilder: (_, _) => const SizedBox(height: FixtureTokens.gap),
        itemBuilder: (_, index) => children[index],
      ),
    ),
  );
}

class FixturePanel extends StatelessWidget {
  const FixturePanel({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(FixtureTokens.gap),
    decoration: BoxDecoration(
      color: FixtureTokens.surface(context),
      borderRadius: BorderRadius.circular(FixtureTokens.radius),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 12,
      children: children,
    ),
  );
}

class FixtureHeading extends StatelessWidget {
  const FixtureHeading(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text,
      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
    ),
  );
}

class FixtureAction extends StatelessWidget {
  const FixtureAction({
    super.key,
    required this.label,
    required this.onPressed,
    this.primary = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final child = Text(label, textAlign: TextAlign.center);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: FixtureTokens.touchTarget),
      child: primary
          ? CupertinoButton.filled(onPressed: onPressed, child: child)
          : CupertinoButton(onPressed: onPressed, child: child),
    );
  }
}

class FixtureStateView extends StatelessWidget {
  const FixtureStateView({
    super.key,
    required this.phase,
    required this.onRetry,
  });
  final FixturePhase phase;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final (title, message) = switch (phase) {
      FixturePhase.initial => ('准备浏览词根', '加载后可查看词根与关联单词。'),
      FixturePhase.loading => ('正在加载', '正在准备内容，请稍候。'),
      FixturePhase.empty => ('暂无词根内容', '词库准备完成后，可在这里开始学习。'),
      FixturePhase.error => ('暂时无法加载', '请重试，或返回上一页。'),
      FixturePhase.data => ('内容已就绪', ''),
    };
    return FixturePanel(
      children: [
        if (phase == FixturePhase.loading &&
            !MediaQuery.disableAnimationsOf(context))
          const ExcludeSemantics(child: CupertinoActivityIndicator()),
        Semantics(liveRegion: true, child: FixtureHeading(title)),
        Text(message),
        if (phase != FixturePhase.loading)
          FixtureAction(
            label: phase == FixturePhase.initial ? '加载词根' : '重新加载',
            onPressed: onRetry,
            primary: true,
          ),
      ],
    );
  }
}

class FixtureContentNotice extends StatelessWidget {
  const FixtureContentNotice({super.key});

  @override
  Widget build(BuildContext context) => Text(
    '演示内容 · 未接入真实词库，学习记录不会保存。',
    style: TextStyle(color: FixtureTokens.secondary(context)),
  );
}
