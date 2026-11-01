import 'dart:async';

import 'package:etyra/app/composition/providers.dart';
import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/page.dart' as domain;
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:etyra/features/words/domain/word.dart';
import 'package:etyra/features/words/domain/word_detail.dart';
import 'package:etyra/features/words/presentation/word_catalog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_words.dart';

Word word(String id, {List<SourceRef> sources = const []}) => Word(
  id: id,
  word: '测试单词 $id',
  normalizedWord: id,
  partOfSpeech: '名词',
  definition: '测试释义 $id',
  translation: '测试翻译 $id',
  pronunciationRef: 'test-only',
  sources: sources,
);

WordDetail detail(
  Word word, {
  List<Root> roots = const [],
  List<Affix> affixes = const [],
  List<WordComponent> components = const [],
  List<ExampleSentence> examples = const [],
}) => WordDetail(
  word: word,
  roots: roots,
  affixes: affixes,
  components: components,
  examples: examples,
);

Widget app(FakeWords fake, Widget page) => ProviderScope(
  overrides: [wordRepositoryProvider.overrideWithValue(fake)],
  child: CupertinoApp(home: page),
);

Future<void> tap(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.tap(find.text(label));
  await tester.pump();
}

void main() {
  testWidgets('真实列表加载与空库，不显示演示内容', (tester) async {
    final wait = Completer<Result<domain.Page<Word>>>();
    final fake = FakeWords()..list = (_) => wait.future;
    await tester.pumpWidget(app(fake, const WordCatalogPage()));
    expect(find.text('正在加载单词'), findsOneWidget);
    wait.complete(Success(domain.Page(items: [])));
    await tester.pumpAndSettle();
    expect(find.text('暂无单词内容'), findsOneWidget);
    expect(find.text('本地词库目前为空。'), findsOneWidget);
    expect(find.textContaining('占位'), findsNothing);
    expect(find.textContaining('示例'), findsNothing);
  });

  testWidgets('列表错误可重试且不泄露内部消息', (tester) async {
    var calls = 0;
    final fake = FakeWords()
      ..list = (_) async => ++calls == 1
          ? const Failure(DomainFailure(FailureKind.storage, 'private.failure'))
          : Success(domain.Page(items: [word('1')]));
    await tester.pumpWidget(app(fake, const WordCatalogPage()));
    await tester.pumpAndSettle();
    expect(find.text('单词暂时无法加载'), findsOneWidget);
    expect(find.textContaining('private.failure'), findsNothing);
    await tap(tester, '重试');
    await tester.pumpAndSettle();
    expect(find.text('测试单词 1'), findsOneWidget);
  });

  testWidgets('分页失败保留内容并用相同 cursor 重试', (tester) async {
    var calls = 0;
    final fake = FakeWords()
      ..list = (cursor) async {
        if (cursor == null) {
          return Success(domain.Page(items: [word('1')], nextCursor: 'opaque'));
        }
        if (++calls == 1) {
          return const Failure(DomainFailure(FailureKind.storage, 'storage'));
        }
        return Success(domain.Page(items: [word('2')]));
      };
    await tester.pumpWidget(app(fake, const WordCatalogPage()));
    await tester.pumpAndSettle();
    await tap(tester, '加载更多');
    await tester.pumpAndSettle();
    expect(find.text('测试单词 1'), findsOneWidget);
    expect(find.text('加载更多失败，请重试。'), findsOneWidget);
    await tap(tester, '重试加载更多');
    await tester.pumpAndSettle();
    expect(find.text('测试单词 2'), findsOneWidget);
    expect(fake.cursors, [null, 'opaque', 'opaque']);
    expect(find.text('加载更多'), findsNothing);
  });

  testWidgets('列表通过稳定 ID 打开详情，缺失内容显示空态', (tester) async {
    String? requested;
    final fake = FakeWords();
    fake.list = (_) async => Success(domain.Page(items: [word('stable')]));
    fake.detail = (id) async {
      requested = id;
      return Success(detail(word(id)));
    };
    await tester.pumpWidget(app(fake, const WordCatalogPage()));
    await tester.pumpAndSettle();
    await tap(tester, '查看测试单词 stable');
    await tester.pumpAndSettle();
    expect(requested, 'stable');
    expect(find.text('名词'), findsOneWidget);
    expect(find.text('测试释义 stable'), findsOneWidget);
    expect(find.text('测试翻译 stable'), findsOneWidget);
    expect(find.text('暂无可追溯来源。'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('暂无例句。'), 250);
    expect(find.text('暂无明确的构词关系。'), findsOneWidget);
    expect(find.text('暂无例句。'), findsOneWidget);
    expect(find.textContaining('播放'), findsNothing);
  });

  testWidgets('详情加载、错误和重试', (tester) async {
    final wait = Completer<Result<WordDetail>>();
    var calls = 0;
    final fake = FakeWords()
      ..detail = (_) =>
          ++calls == 1 ? wait.future : Future.value(Success(detail(word('1'))));
    await tester.pumpWidget(
      app(fake, const WordCatalogDetailPage(wordId: '1')),
    );
    expect(find.text('正在加载单词详情'), findsOneWidget);
    wait.complete(const Failure(DomainFailure(FailureKind.storage, 'private')));
    await tester.pumpAndSettle();
    expect(find.text('单词详情暂时无法加载'), findsOneWidget);
    await tap(tester, '重试');
    await tester.pumpAndSettle();
    expect(find.text('测试单词 1'), findsOneWidget);
  });

  testWidgets('不存在的单词显示可重试状态', (tester) async {
    await tester.pumpWidget(
      app(FakeWords(), const WordCatalogDetailPage(wordId: 'missing')),
    );
    await tester.pumpAndSettle();
    expect(find.text('未找到该单词'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });

  testWidgets('放大文字和深色下详情仍可滚动并朗读标题', (tester) async {
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
    final semantics = tester.ensureSemantics();
    final fake = FakeWords()..detail = (_) async => Success(detail(word('1')));
    await tester.pumpWidget(
      app(fake, const WordCatalogDetailPage(wordId: '1')),
    );
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('测试单词 1'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('暂无例句。'), 250);
    expect(find.text('暂无例句。'), findsOneWidget);
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });

  testWidgets('显式关系、词根词缀、来源及例句如实展示', (tester) async {
    final source = SourceRef(id: 's', title: '测试来源', licenseName: '测试许可');
    final root = Root(
      id: 'r',
      lemma: 'r',
      displayForm: '测试词根',
      language: '测试',
      meaning: '测试',
      verificationStatus: VerificationStatus.unverified,
      sources: [],
    );
    final affix = Affix(
      id: 'a',
      form: '测试词缀',
      kind: AffixKind.suffix,
      meaning: '测试',
      verificationStatus: VerificationStatus.unverified,
      sources: [],
    );
    final components = [
      WordComponent(
        wordId: '1',
        componentType: ComponentType.root,
        componentId: 'r',
        role: ComponentRole.root,
        confidence: .8,
        sources: [source],
      ),
      WordComponent(
        wordId: '1',
        componentType: ComponentType.affix,
        componentId: 'a',
        role: ComponentRole.suffix,
        sources: [],
      ),
    ];
    final example = ExampleSentence(
      id: 'e',
      wordId: '1',
      sentence: '测试例句',
      translation: '测试译文',
      sources: [source],
    );
    final fake = FakeWords()
      ..detail = (_) async => Success(
        detail(
          word('1', sources: [source]),
          roots: [root],
          affixes: [affix],
          components: components,
          examples: [example],
        ),
      );
    await tester.pumpWidget(
      app(fake, const WordCatalogDetailPage(wordId: '1')),
    );
    await tester.pumpAndSettle();
    expect(find.text('测试来源 · 测试许可'), findsWidgets);
    await tester.scrollUntilVisible(find.text('词根：测试词根 · 内容待核验'), 250);
    expect(find.text('角色：词根 · 记录置信度 80%（不代表已核验）'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('词缀：测试词缀 · 内容待核验'), 250);
    expect(find.text('角色：后缀 · 未提供有效置信度'), findsOneWidget);
    expect(find.text('关系暂无来源。'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('测试例句'), 250);
    await tester.scrollUntilVisible(find.text('测试译文'), 250);
    expect(find.text('测试译文'), findsOneWidget);
  });
}
