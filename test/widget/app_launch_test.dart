import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:etyra/app/etyra_app.dart';

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
    expect(find.text('模拟首次提交失败'), findsNothing);
    expect(find.text('查看列表'), findsNothing);
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
      expect(tester.takeException(), isNull);
    },
  );
}
