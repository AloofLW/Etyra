import 'dart:async';

import 'package:etyra/app/composition/providers.dart';
import 'package:etyra/features/roots/domain/root.dart';
import 'package:etyra/features/roots/presentation/root_catalog_page.dart';
import 'package:etyra/features/shared/domain/content_types.dart';
import 'package:etyra/features/shared/domain/page.dart' as domain;
import 'package:etyra/features/shared/domain/result.dart';
import 'package:etyra/features/shared/domain/source_ref.dart';
import 'package:etyra/features/words/domain/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/fake_roots.dart';

Root root(
  String id, {
  VerificationStatus status = VerificationStatus.unverified,
  bool source = false,
}) => Root(
  id: id,
  lemma: id,
  displayForm: '词根 $id',
  language: '测试语言',
  meaning: '测试释义 $id',
  originNote: '测试词源 $id',
  verificationStatus: status,
  sources: source
      ? [SourceRef(id: 'source', title: '测试来源', licenseName: '测试许可')]
      : [],
);

RootDetail detail(Root value, {List<Word> words = const []}) => RootDetail(
  root: value,
  affixes: [],
  words: words,
  components: [],
  examples: [],
);

Widget app(FakeRoots fake, Widget page) => ProviderScope(
  overrides: [rootRepositoryProvider.overrideWithValue(fake)],
  child: CupertinoApp(home: page),
);

Future<void> tap(WidgetTester tester, String text) async {
  await tester.ensureVisible(find.text(text));
  await tester.tap(find.text(text));
  await tester.pump();
}

void main() {
  testWidgets('真实列表加载后显示空库，不显示演示词条', (tester) async {
    final wait = Completer<Result<domain.Page<Root>>>();
    final fake = FakeRoots()..list = (_) => wait.future;
    await tester.pumpWidget(app(fake, const RootCatalogPage()));
    expect(find.text('正在加载词根'), findsOneWidget);
    wait.complete(Success(domain.Page(items: [])));
    await tester.pumpAndSettle();
    expect(find.text('暂无词根内容'), findsOneWidget);
    expect(find.text('本地词库目前为空。'), findsOneWidget);
    expect(find.text('词根示例 A'), findsNothing);
  });

  testWidgets('列表错误可重试，错误详情不泄露', (tester) async {
    var count = 0;
    final fake = FakeRoots()
      ..list = (_) async => ++count == 1
          ? const Failure(DomainFailure(FailureKind.storage, 'internal.secret'))
          : Success(domain.Page(items: [root('1')]));
    await tester.pumpWidget(app(fake, const RootCatalogPage()));
    await tester.pumpAndSettle();
    expect(find.text('词根暂时无法加载'), findsOneWidget);
    expect(find.textContaining('internal.secret'), findsNothing);
    await tap(tester, '重试');
    await tester.pumpAndSettle();
    expect(find.text('词根 1'), findsOneWidget);
    expect(count, 2);
  });

  testWidgets('真实列表点击后按稳定 ID 加载详情', (tester) async {
    String? requested;
    final fake = FakeRoots();
    fake.list = (_) async => Success(domain.Page(items: [root('r-42')]));
    fake.detail = (id) async {
      requested = id;
      return Success(detail(root(id)));
    };
    await tester.pumpWidget(app(fake, const RootCatalogPage()));
    await tester.pumpAndSettle();
    await tap(tester, '查看词根 r-42');
    await tester.pumpAndSettle();
    expect(requested, 'r-42');
    expect(find.text('释义待核验：测试释义 r-42'), findsOneWidget);
    expect(find.text('真实词根学习尚未接入。'), findsOneWidget);
  });

  testWidgets('分页失败保留已有内容并使用同一 cursor 重试', (tester) async {
    var attempts = 0;
    final fake = FakeRoots()
      ..list = (cursor) async {
        if (cursor == null) {
          return Success(domain.Page(items: [root('1')], nextCursor: 'opaque'));
        }
        if (++attempts == 1) {
          return const Failure(
            DomainFailure(FailureKind.storage, 'storage.failed'),
          );
        }
        return Success(domain.Page(items: [root('2')]));
      };
    await tester.pumpWidget(app(fake, const RootCatalogPage()));
    await tester.pumpAndSettle();
    await tap(tester, '加载更多');
    await tester.pumpAndSettle();
    expect(find.text('词根 1'), findsOneWidget);
    expect(find.text('加载更多失败，请重试。'), findsOneWidget);
    await tap(tester, '重试加载更多');
    await tester.pumpAndSettle();
    expect(find.text('词根 2'), findsOneWidget);
    expect(fake.cursors, [null, 'opaque', 'opaque']);
    expect(find.text('加载更多'), findsNothing);
  });

  testWidgets('详情加载、失败重试、来源和关联空状态', (tester) async {
    var count = 0;
    final wait = Completer<Result<RootDetail>>();
    final fake = FakeRoots()
      ..detail = (_) =>
          ++count == 1 ? wait.future : Future.value(Success(detail(root('1'))));
    await tester.pumpWidget(
      app(fake, const RootCatalogDetailPage(rootId: '1')),
    );
    expect(find.text('正在加载词根详情'), findsOneWidget);
    wait.complete(const Failure(DomainFailure(FailureKind.storage, 'private')));
    await tester.pumpAndSettle();
    expect(find.text('词根详情暂时无法加载'), findsOneWidget);
    await tap(tester, '重试');
    await tester.pumpAndSettle();
    expect(find.text('释义待核验：测试释义 1'), findsOneWidget);
    expect(find.text('暂无可追溯来源。'), findsOneWidget);
    expect(find.text('测试词源 1'), findsNothing);
    await tester.scrollUntilVisible(find.text('暂无关联单词。'), 250);
    expect(find.text('暂无关联单词。'), findsOneWidget);
  });

  testWidgets('已核验内容显示来源，关联关系仍提示待核验', (tester) async {
    final verified = root(
      '2',
      status: VerificationStatus.verified,
      source: true,
    );
    final word = Word(
      id: 'w',
      word: '测试单词',
      normalizedWord: 'test',
      definition: '占位',
      sources: [],
    );
    final fake = FakeRoots()
      ..detail = (_) async => Success(detail(verified, words: [word]));
    await tester.pumpWidget(
      app(fake, const RootCatalogDetailPage(rootId: '2')),
    );
    await tester.pumpAndSettle();
    expect(find.text('已核验'), findsOneWidget);
    expect(find.text('测试词源 2'), findsOneWidget);
    expect(find.text('测试来源 · 测试许可'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('测试单词'), 250);
    expect(find.text('关联关系尚需核验。'), findsOneWidget);
    expect(find.text('测试单词'), findsOneWidget);
  });

  testWidgets('找不到详情显示可重试状态', (tester) async {
    await tester.pumpWidget(
      app(FakeRoots(), const RootCatalogDetailPage(rootId: 'missing')),
    );
    await tester.pumpAndSettle();
    expect(find.text('未找到该词根'), findsOneWidget);
    expect(find.text('重试'), findsOneWidget);
  });
}
