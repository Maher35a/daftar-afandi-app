import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppTheme {
  // 🎨 Light Theme
  static final ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.mandyRed,
    appBarStyle: FlexAppBarStyle.material,
    useMaterial3: true,
    fontFamily: "Graphik Arabic",
  );

  // 🌙 Dark Theme
  static final ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.mandyRed,
    appBarStyle: FlexAppBarStyle.material,
    useMaterial3: true,
    fontFamily: "Graphik Arabic",
  );
}
