import 'package:flutter/material.dart';
import 'package:trivia_app/Themes/base_theme.dart';

class Trivia3Theme {
  static ThemeData get theme {
    return BaseTheme.base(
      scaffoldBackgroundColor: Colors.amber,
      primaryColor: Color.fromARGB(255, 88, 84, 0),
    );
  }
}