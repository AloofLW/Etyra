import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/roots/presentation/root_learning_fixture_preview.dart';
import 'etyra_theme.dart';

/// Shared app shell and dependency composition owner: conversation 01.
class EtyraApp extends StatelessWidget {
  const EtyraApp({super.key});

  @override
  Widget build(BuildContext context) => ProviderScope(
    child: CupertinoApp(
      title: 'Etyra',
      theme: EtyraTheme.cupertino,
      home: const RootLearningFixturePreview(),
    ),
  );
}
