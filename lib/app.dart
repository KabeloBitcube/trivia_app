import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/Home/home.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: F.name == Flavor.trivia1.name
          ? ThemeData(scaffoldBackgroundColor: Colors.purple)
          : ThemeData(scaffoldBackgroundColor: Colors.blue),
      home: _flavorBanner(child: Trivia1HomePage(), show: kDebugMode),
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
