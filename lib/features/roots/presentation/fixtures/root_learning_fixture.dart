import 'package:flutter/foundation.dart';

/// Presentation-only examples. These are not domain models or seed content.
enum FixturePhase { initial, loading, data, empty, error }

enum FixtureFeedback { recalled, needsPractice, skipped }

@immutable
class RootLearningFixture {
  const RootLearningFixture({required this.label, required this.words});

  final String label;
  final List<String> words;

  static const samples = <RootLearningFixture>[
    RootLearningFixture(label: '词根示例 A', words: ['关联单词占位 A', '关联单词占位 B']),
    RootLearningFixture(label: '词根示例 B', words: []),
  ];
}

/// A disposable UI simulation; never persists answers or claims saved progress.
class FixtureSessionController extends ChangeNotifier {
  FixtureSessionController({this.failNextWrite = false});

  bool failNextWrite;
  bool busy = false;
  bool revealed = false;
  bool abandoned = false;
  bool finished = false;
  String? error;
  FixtureFeedback? feedback;
  int position = 0;
  int completed = 0;
  int skipped = 0;
  final int total = 2;
  bool _disposed = false;

  void reveal() {
    if (busy || finished || feedback != null) return;
    revealed = true;
    notifyListeners();
  }

  Future<void> submit(FixtureFeedback value) async {
    if (busy || finished || feedback != null) return;
    if (!revealed && value != FixtureFeedback.skipped) return;
    busy = true;
    error = null;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (_disposed) return;
    busy = false;
    if (failNextWrite) {
      failNextWrite = false;
      error = '本次反馈未提交，请重试。';
    } else {
      feedback = value;
      if (value == FixtureFeedback.skipped) {
        skipped++;
      } else {
        completed++;
      }
    }
    notifyListeners();
  }

  void next() {
    if (busy || feedback == null || finished) return;
    if (position + 1 == total) {
      finished = true;
    } else {
      position++;
      revealed = false;
      feedback = null;
      error = null;
    }
    notifyListeners();
  }

  void abandon() {
    if (busy || finished) return;
    abandoned = true;
    finished = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
