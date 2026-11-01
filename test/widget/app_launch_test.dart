import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:etyra/app/etyra_app.dart';
import 'package:etyra/features/roots/presentation/widgets/fixture_widgets.dart';

TextStyle effectiveStyle(WidgetTester tester, String label) {
  final finder = find.text(label).first;
  final text = tester.widget<Text>(finder);
  return DefaultTextStyle.of(tester.element(finder)).style.merge(text.style);
}

double contrast(Color first, Color second) {
  final a = first.computeLuminance();
  final b = second.computeLuminance();
  return (a > b ? a + 0.05 : b + 0.05) / (a > b ? b + 0.05 : a + 0.05);
}

void main() {
  testWidgets('launches the learner home without preview controls', (
    tester,
  ) async {
    await tester.pumpWidget(const EtyraApp());

    expect(find.byType(CupertinoApp), findsOneWidget);
    expect(find.text('从词根开始，\n理解单词。'), findsOneWidget);
    expect(find.text('开始学习演示'), findsOneWidget);
    expect(find.text('演示内容 · 尚未接入真实词库，学习记录不会保存。'), findsOneWidget);
    expect(find.text('预览工具'), findsOneWidget);
    expect(find.text('认识构词成分，探索它与单词的联系。'), findsNothing);
    expect(find.text('从一个词根出发，看看学习过程。'), findsNothing);
    expect(find.text('模拟首次提交失败'), findsNothing);
    expect(find.text('查看列表'), findsNothing);
    expect(effectiveStyle(tester, '开始学习演示').fontWeight, FontWeight.w500);
    expect(effectiveStyle(tester, '学习').fontWeight, FontWeight.w600);
    expect(
      effectiveStyle(tester, '演示内容 · 尚未接入真实词库，学习记录不会保存。').fontWeight,
      FontWeight.w500,
    );
    final context = tester.element(find.text('开始学习演示'));
    expect(
      contrast(
        FixtureTokens.secondary(context),
        FixtureTokens.background(context),
      ),
      greaterThanOrEqualTo(4.5),
    );
  });

  testWidgets(
    'learner home remains usable with large text and dark appearance',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
        tester.platformDispatcher.clearTextScaleFactorTestValue();
        tester.platformDispatcher.clearPlatformBrightnessTestValue();
      });

      await tester.pumpWidget(const EtyraApp());
      await tester.ensureVisible(find.text('开始学习演示'));
      await tester.tap(find.text('开始学习演示'));
      await tester.pumpAndSettle();
      expect(find.text('词根示例 A'), findsOneWidget);
      expect(find.text('返回'), findsOneWidget);
      expect(find.byType(CupertinoNavigationBarBackButton), findsNothing);
      await tester.scrollUntilVisible(find.text('开始词根学习'), 250);
      final context = tester.element(find.text('开始词根学习'));
      final button = tester.widget<CupertinoButton>(
        find.widgetWithText(CupertinoButton, '开始词根学习'),
      );
      expect(button.color, FixtureTokens.warmAction.resolveFrom(context));
      expect(effectiveStyle(tester, '开始词根学习').fontWeight, FontWeight.w500);
      expect(effectiveStyle(tester, '释义待接入审核内容').fontWeight, FontWeight.w500);
      expect(effectiveStyle(tester, '构词关系').fontWeight, FontWeight.w600);
      expect(
        contrast(
          FixtureTokens.secondary(context),
          FixtureTokens.background(context),
        ),
        greaterThanOrEqualTo(4.5),
      );
      expect(
        contrast(
          FixtureTokens.secondary(context),
          FixtureTokens.surface(context),
        ),
        greaterThanOrEqualTo(4.5),
      );
      expect(tester.takeException(), isNull);
    },
  );
}
