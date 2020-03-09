import 'package:flutter/material.dart';

import 'page/home.dart';
import 'page/on_boarding.dart';
import 'screen/splash.dart';

void main() =>  runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => MyHomePage(),
        '/onboard': (context) => MyOnBoardingPages(),
      },
    );
  }
}