import 'package:flutter/material.dart';
import 'package:trivia_app/Themes/base_theme.dart';

class Trivia1Theme {
  static ThemeData get theme {
    return BaseTheme.base(
      scaffoldBackgroundColor: Colors.purple,
      primaryColor: Color.fromARGB(255, 56, 1, 66),
    );
  }
}
