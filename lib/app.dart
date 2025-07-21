import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/Home/home.dart';
import 'package:trivia_app/Themes/trivia1_theme.dart';
import 'package:trivia_app/Themes/trivia2_theme.dart';
import 'package:trivia_app/Themes/trivia3_theme.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: (F.name == Flavor.trivia1.name)
          ? Trivia1Theme.theme
          : (F.name == Flavor.trivia2.name)
          ? Trivia2Theme.theme
          : Trivia3Theme.theme,
      home: _flavorBanner(child: TriviaHomePage(), show: kDebugMode),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          location: BannerLocation.topStart,
          message: F.name,
          color: Colors.green.withAlpha(150),
          textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 1.0,
          ),
          textDirection: TextDirection.ltr,
          child: child,
        )
      : Container(child: child);
}
