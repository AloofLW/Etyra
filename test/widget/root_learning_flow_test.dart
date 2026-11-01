import 'package:etyra/app/etyra_app.dart';
import 'package:etyra/features/roots/presentation/fixtures/root_learning_fixture.dart';
import 'package:etyra/features/roots/presentation/root_learning_pages.dart';
import 'package:etyra/features/study/presentation/fixture_study_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> tapText(WidgetTester tester, String text) async {
  final target = find.text(text);
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pump();
}

Future<void> loadFixture(WidgetTester tester) async {
  expect(find.text('正在加载'), findsOneWidget);
  await tester.pump(const Duration(milliseconds: 700));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('应用入口可进入词根列表、详情和学习', (tester) async {
    await tester.pumpWidget(const EtyraApp());
    expect(find.text('词根学习界面预览'), findsOneWidget);

    await tester.tap(find.text('查看列表').first);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('准备浏览词根'), findsOneWidget);
    await tapText(tester, '加载词根');
    await loadFixture(tester);
    await tapText(tester, '查看词根示例 A');
    await tester.pumpAndSettle();
    expect(find.text('尚无可追溯来源 · 待核验'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('开始词根学习'), 300);
    await tapText(tester, '开始词根学习');
    await tester.pumpAndSettle();
    await tapText(tester, '开始预览');
    await tester.pumpAndSettle();
    expect(find.text('回忆提示占位 1'), findsOneWidget);
  });

  for (final isDetail in [false, true]) {
    final kind = isDetail ? '详情' : '列表';
    Widget page(FixturePhase phase) => CupertinoApp(
      home: isDetail
          ? RootFixtureDetailPage(
              root: RootLearningFixture.samples.first,
              initialPhase: phase,
            )
          : RootFixtureListPage(initialPhase: phase),
    );

    for (final phase in [
      FixturePhase.initial,
      FixturePhase.empty,
      FixturePhase.error,
    ]) {
      testWidgets('$kind 的 ${phase.name} 状态可加载或重试', (tester) async {
        await tester.pumpWidget(page(phase));
        expect(
          find.text(switch (phase) {
            FixturePhase.initial => '准备浏览词根',
            FixturePhase.empty => '暂无词根内容',
            FixturePhase.error => '暂时无法加载',
            _ => throw StateError('unexpected phase'),
          }),
          findsOneWidget,
        );
        await tapText(tester, phase == FixturePhase.initial ? '加载词根' : '重新加载');
        await loadFixture(tester);
        expect(find.text('词根示例 A'), findsOneWidget);
        expect(
          find.text('尚无可追溯来源 · 待核验'),
          isDetail ? findsOneWidget : findsNothing,
        );
      });
    }

    testWidgets('$kind 的加载态完成后展示数据', (tester) async {
      await tester.pumpWidget(page(FixturePhase.loading));
      await loadFixture(tester);
      expect(find.text('词根示例 A'), findsOneWidget);
    });
  }

  testWidgets('无关联单词的详情有说明', (tester) async {
    await tester.pumpWidget(
      CupertinoApp(
        home: RootFixtureDetailPage(root: RootLearningFixture.samples.last),
      ),
    );
    await tester.scrollUntilVisible(find.text('暂无关联单词。仍可预览词根学习流程。'), 300);
    expect(find.text('暂无关联单词。仍可预览词根学习流程。'), findsOneWidget);
    expect(find.text('尚无可追溯来源 · 待核验'), findsOneWidget);
  });

  testWidgets('查看答案、反馈及跳过后总结计数正确', (tester) async {
    await tester.pumpWidget(
      const CupertinoApp(home: FixtureStudyPage(rootLabel: '测试词根')),
    );
    expect(find.text('答案与解释'), findsNothing);
    await tapText(tester, '显示答案');
    expect(find.text('答案与解释'), findsOneWidget);
    await tapText(tester, '知道了');
    expect(find.text('正在提交反馈…'), findsOneWidget);
    expect(
      tester
          .widget<CupertinoButton>(find.widgetWithText(CupertinoButton, '知道了'))
          .onPressed,
      isNull,
    );
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('已标记“知道了”。这表示本次回忆反馈，不代表长期掌握。'), findsOneWidget);
    expect(find.text('知道了'), findsNothing);
    await tapText(tester, '下一项');
    expect(find.text('回忆提示占位 2'), findsOneWidget);
    await tapText(tester, '跳过本项');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('已跳过。本项不计入完成数。'), findsOneWidget);
    await tapText(tester, '查看总结');
    expect(find.text('本组学习已完成'), findsOneWidget);
    expect(find.text('本组数量：2'), findsOneWidget);
    expect(find.text('完成：1'), findsOneWidget);
    expect(find.text('跳过：1'), findsOneWidget);
    expect(find.text('尚未完成：0'), findsOneWidget);
  });

  testWidgets('提交失败后重试不推进也不重复计数', (tester) async {
    await tester.pumpWidget(
      const CupertinoApp(
        home: FixtureStudyPage(rootLabel: '测试词根', failNextWrite: true),
      ),
    );
    await tapText(tester, '显示答案');
    await tapText(tester, '需要再学');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('本次反馈未提交，请重试。'), findsOneWidget);
    expect(find.text('回忆提示占位 1'), findsOneWidget);
    expect(find.text('第 1 / 2 项 · 完成 0 · 跳过 0'), findsOneWidget);
    await tapText(tester, '需要再学');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('已标记“需要再学”。'), findsOneWidget);
    expect(find.text('第 1 / 2 项 · 完成 1 · 跳过 0'), findsOneWidget);
    expect(find.text('需要再学'), findsNothing);
  });

  testWidgets('退出可取消；确认后总结保留已完成项', (tester) async {
    await tester.pumpWidget(
      const CupertinoApp(home: FixtureStudyPage(rootLabel: '测试词根')),
    );
    await tapText(tester, '显示答案');
    await tapText(tester, '知道了');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    await tapText(tester, '下一项');
    await tapText(tester, '退出');
    await tester.pumpAndSettle();
    expect(find.text('结束本次学习？'), findsOneWidget);
    await tapText(tester, '继续学习');
    await tester.pumpAndSettle();
    expect(find.text('回忆提示占位 2'), findsOneWidget);
    await tapText(tester, '退出');
    await tester.pumpAndSettle();
    await tapText(tester, '结束学习');
    await tester.pumpAndSettle();
    expect(find.text('本次学习已结束'), findsOneWidget);
    expect(find.text('完成：1'), findsOneWidget);
    expect(find.text('跳过：0'), findsOneWidget);
    expect(find.text('尚未完成：1'), findsOneWidget);
  });
}
