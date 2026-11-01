import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:etyra/app/etyra_app.dart';

void main() {
  testWidgets('launches the Cupertino fixture preview', (tester) async {
    await tester.pumpWidget(const EtyraApp());

    expect(find.byType(CupertinoApp), findsOneWidget);
    expect(find.text('词根学习界面预览'), findsOneWidget);
    expect(find.text('选择列表或详情的首屏状态。重新加载后进入正常占位内容。'), findsOneWidget);
  });
}
