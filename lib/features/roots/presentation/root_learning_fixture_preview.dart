import 'package:flutter/cupertino.dart';

import '../../words/presentation/word_catalog_page.dart';
import 'fixtures/root_learning_fixture.dart';
import 'root_catalog_page.dart';
import 'root_learning_pages.dart';
import 'widgets/fixture_widgets.dart';

/// Learner-facing entry point; the preview tools remain available separately.
class RootLearningFixturePreview extends StatelessWidget {
  const RootLearningFixturePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: FixtureTypography.theme(context),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: FixtureTokens.background(context),
          activeColor: FixtureTokens.accent(context),
          inactiveColor: FixtureTokens.secondary(context),
          iconSize: 26,
          height: 58,
          border: const Border(top: BorderSide.none),
          items: const [
            BottomNavigationBarItem(
              icon: _TabIcon(_TabSymbol.study),
              label: '学习',
            ),
            BottomNavigationBarItem(
              icon: _TabIcon(_TabSymbol.roots),
              label: '词根',
            ),
            BottomNavigationBarItem(
              icon: _TabIcon(_TabSymbol.words),
              label: '单词',
            ),
            BottomNavigationBarItem(
              icon: _TabIcon(_TabSymbol.settings),
              label: '设置',
            ),
          ],
        ),
        tabBuilder: (context, index) => switch (index) {
          0 => const _LearnerHome(),
          1 => const RootCatalogPage(),
          2 => const WordCatalogPage(),
          _ => const _UnavailablePage(title: '设置', message: '设置功能尚未接入。'),
        },
      ),
    );
  }
}

enum _TabSymbol { study, roots, words, settings }

/// Consistent SF-style outlines drawn without a bundled icon font.
class _TabIcon extends StatelessWidget {
  const _TabIcon(this.symbol);
  final _TabSymbol symbol;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: CustomPaint(
      size: const Size(26, 26),
      painter: _TabIconPainter(symbol, IconTheme.of(context).color!),
    ),
  );
}

class _TabIconPainter extends CustomPainter {
  const _TabIconPainter(this.symbol, this.color);
  final _TabSymbol symbol;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24, size.height / 24);
    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    switch (symbol) {
      case _TabSymbol.study:
        final path = Path()
          ..moveTo(3, 6)
          ..quadraticBezierTo(8, 4, 12, 7)
          ..quadraticBezierTo(16, 4, 21, 6)
          ..lineTo(21, 18)
          ..quadraticBezierTo(16, 16, 12, 19)
          ..quadraticBezierTo(8, 16, 3, 18)
          ..close();
        canvas.drawPath(path, line);
        canvas.drawLine(const Offset(12, 7), const Offset(12, 19), line);
      case _TabSymbol.roots:
        canvas.drawLine(const Offset(12, 20), const Offset(12, 11), line);
        canvas.drawLine(const Offset(12, 15), const Offset(6, 9), line);
        canvas.drawLine(const Offset(12, 12), const Offset(18, 7), line);
        for (final point in [
          const Offset(6, 8),
          const Offset(12, 6),
          const Offset(18, 6),
        ]) {
          canvas.drawCircle(point, 2, line);
        }
        canvas.drawLine(const Offset(12, 8), const Offset(12, 11), line);
      case _TabSymbol.words:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(5, 3, 14, 18),
            const Radius.circular(2),
          ),
          line,
        );
        canvas.drawLine(const Offset(9, 8), const Offset(15, 8), line);
        canvas.drawLine(const Offset(9, 12), const Offset(15, 12), line);
        canvas.drawLine(const Offset(9, 16), const Offset(13, 16), line);
      case _TabSymbol.settings:
        canvas.drawCircle(const Offset(12, 12), 7, line);
        canvas.drawCircle(const Offset(12, 12), 2.4, line);
        for (final (start, end) in [
          (const Offset(12, 2), const Offset(12, 5)),
          (const Offset(12, 19), const Offset(12, 22)),
          (const Offset(2, 12), const Offset(5, 12)),
          (const Offset(19, 12), const Offset(22, 12)),
          (const Offset(5, 5), const Offset(7, 7)),
          (const Offset(17, 17), const Offset(19, 19)),
          (const Offset(19, 5), const Offset(17, 7)),
          (const Offset(7, 17), const Offset(5, 19)),
        ]) {
          canvas.drawLine(start, end, line);
        }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TabIconPainter oldDelegate) =>
      oldDelegate.symbol != symbol || oldDelegate.color != color;
}

class _UnavailablePage extends StatelessWidget {
  const _UnavailablePage({required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: title,
    children: [
      const FixtureContentNotice(),
      FixtureHeading(title),
      Text(message),
    ],
  );
}

class _LearnerHome extends StatelessWidget {
  const _LearnerHome();

  @override
  Widget build(BuildContext context) {
    final text = CupertinoTheme.of(context).textTheme;
    return CupertinoPageScaffold(
      backgroundColor: FixtureTokens.background(context),
      navigationBar: CupertinoNavigationBar(
        border: null,
        backgroundColor: FixtureTokens.background(context),
        automaticallyImplyLeading: false,
        middle: const Text('Etyra'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).push<void>(
            FixturePageRoute<void>(
              context: context,
              builder: (_) => const _PreviewToolsPage(),
            ),
          ),
          child: Text(
            '预览工具',
            style: TextStyle(color: FixtureTokens.accent(context)),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            Semantics(
              header: true,
              child: Text(
                '从词根开始，\n理解单词。',
                style: text.navLargeTitleTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(height: 24),
            CupertinoButton(
              color: FixtureTokens.warmAction.resolveFrom(context),
              onPressed: () => Navigator.of(context).push<void>(
                FixturePageRoute<void>(
                  context: context,
                  builder: (_) => RootFixtureDetailPage(
                    root: RootLearningFixture.samples.first,
                  ),
                ),
              ),
              child: const Text(
                '开始学习演示',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontWeight: FixtureTypography.bodyWeight,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '演示内容 · 尚未接入真实词库，学习记录不会保存。',
              style: text.textStyle.copyWith(
                color: FixtureTokens.secondary(context),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.of(context).push<void>(
                  FixturePageRoute<void>(
                    context: context,
                    builder: (_) => const RootFixtureListPage(),
                  ),
                ),
                child: Text(
                  '浏览演示词根  ›',
                  style: TextStyle(color: FixtureTokens.accent(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreviewToolsPage extends StatefulWidget {
  const _PreviewToolsPage();

  @override
  State<_PreviewToolsPage> createState() => _PreviewToolsPageState();
}

class _PreviewToolsPageState extends State<_PreviewToolsPage> {
  bool failNextWrite = false;

  @override
  Widget build(BuildContext context) => FixtureScaffold(
    title: '预览工具',
    children: [
      const Text('演示不同页面状态；重新加载后显示演示内容。'),
      CupertinoListSection.insetGrouped(
        margin: EdgeInsets.zero,
        children: [
          CupertinoListTile(
            title: const Text('模拟首次提交失败'),
            trailing: Semantics(
              label: '模拟首次提交失败',
              child: CupertinoSwitch(
                value: failNextWrite,
                activeTrackColor: FixtureTokens.warmAction.resolveFrom(context),
                onChanged: (value) => setState(() => failNextWrite = value),
              ),
            ),
          ),
        ],
      ),
      for (final phase in FixturePhase.values)
        FixturePanel(
          children: [
            FixtureHeading(_phaseLabel(phase)),
            Wrap(
              spacing: 12,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => RootFixtureListPage(
                        initialPhase: phase,
                        failNextWrite: failNextWrite,
                      ),
                    ),
                  ),
                  child: Text(
                    '查看列表',
                    style: TextStyle(color: FixtureTokens.accent(context)),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.of(context).push<void>(
                    FixturePageRoute<void>(
                      context: context,
                      builder: (_) => RootFixtureDetailPage(
                        root: RootLearningFixture.samples.first,
                        initialPhase: phase,
                        failNextWrite: failNextWrite,
                      ),
                    ),
                  ),
                  child: Text(
                    '查看详情',
                    style: TextStyle(color: FixtureTokens.accent(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
    ],
  );

  String _phaseLabel(FixturePhase phase) => switch (phase) {
    FixturePhase.initial => '尚未加载',
    FixturePhase.loading => '加载中',
    FixturePhase.data => '正常内容',
    FixturePhase.empty => '暂无内容',
    FixturePhase.error => '加载失败',
  };
}
