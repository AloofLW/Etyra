import 'package:flutter/cupertino.dart';

/// Semantic iOS colors remain adaptive to system appearance and contrast.
abstract final class EtyraTheme {
  static const cupertino = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.systemBackground,
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  );
}
