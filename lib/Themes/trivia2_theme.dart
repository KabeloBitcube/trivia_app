import 'package:flutter/material.dart';
import 'package:trivia_app/Themes/base_theme.dart';

class Trivia2Theme {
  static ThemeData get theme {
    return BaseTheme.base(
      scaffoldBackgroundColor: Colors.lightBlue,
      primaryColor: Color.fromARGB(255, 0, 60, 80),
    );
  }
}