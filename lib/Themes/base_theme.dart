import 'package:flutter/material.dart';

class BaseTheme {
  static ThemeData base ({required Color scaffoldBackgroundColor, required Color primaryColor}) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      primaryColor: primaryColor
    );
  }
}