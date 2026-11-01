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
  static const warmBackground = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFAF6EF),
    darkColor: Color(0xFF1C1917),
  );
  static const warmSurface = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFBF6),
    darkColor: Color(0xFF2C2521),
  );
  static const warmAction = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFA04A38),
    darkColor: Color(0xFF9A4535),
  );
  static const warmLink = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF91412F),
    darkColor: Color(0xFFEEAB96),
  );
  static const secondaryText = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF584E48),
    darkColor: Color(0xFFCCBFB5),
  );
  static Color accent(BuildContext context) => warmLink.resolveFrom(context);
  static Color background(BuildContext context) =>
      warmBackground.resolveFrom(context);
  static Color surface(BuildContext context) =>
      warmSurface.resolveFrom(context);
  static Color secondary(BuildContext context) =>
      secondaryText.resolveFrom(context);
}

abstract final class FixtureTypography {
  static const bodyWeight = FontWeight.w500;
  static const headingWeight = FontWeight.w600;

  static CupertinoThemeData theme(BuildContext context) {
    final base = CupertinoTheme.of(context);
    final text = base.textTheme;
    return base.copyWith(
      primaryColor: FixtureTokens.warmLink,
      textTheme: text.copyWith(
        textStyle: text.textStyle.copyWith(fontWeight: bodyWeight),
        actionTextStyle: text.actionTextStyle.copyWith(fontWeight: bodyWeight),
        navTitleTextStyle: text.navTitleTextStyle.copyWith(
          fontWeight: headingWeight,
        ),
        navLargeTitleTextStyle: text.navLargeTitleTextStyle.copyWith(
          fontWeight: headingWeight,
        ),
        navActionTextStyle: text.navActionTextStyle.copyWith(
          fontWeight: bodyWeight,
        ),
        tabLabelTextStyle: text.tabLabelTextStyle.copyWith(
          fontWeight: bodyWeight,
        ),
      ),
    );
  }
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
  Widget build(BuildContext context) => CupertinoTheme(
    data: FixtureTypography.theme(context),
    child: CupertinoPageScaffold(
      backgroundColor: FixtureTokens.background(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        border: null,
        backgroundColor: FixtureTokens.background(context),
        automaticallyImplyLeading: false,
        leading:
            leading ??
            (Navigator.of(context).canPop()
                ? CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      '返回',
                      style: TextStyle(color: FixtureTokens.accent(context)),
                    ),
                  )
                : null),
      ),
      child: DefaultTextStyle.merge(
        style: FixtureTypography.theme(context).textTheme.textStyle,
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(FixtureTokens.gap),
            itemCount: children.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: FixtureTokens.gap),
            itemBuilder: (_, index) => children[index],
          ),
        ),
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
      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
          .copyWith(fontWeight: FixtureTypography.headingWeight),
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
    final child = Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: primary ? CupertinoColors.white : FixtureTokens.accent(context),
        fontWeight: FixtureTypography.bodyWeight,
      ),
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: FixtureTokens.touchTarget),
      child: primary
          ? CupertinoButton(
              color: FixtureTokens.warmAction.resolveFrom(context),
              onPressed: onPressed,
              child: child,
            )
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
    style: TextStyle(
      color: FixtureTokens.secondary(context),
      fontWeight: FixtureTypography.bodyWeight,
    ),
  );
}
