import 'package:blog_news/elements/scrollbehavior.dart';
import 'package:blog_news/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData.dark().copyWith(
        backgroundColor: Colors.grey[900]
      ),
      home: SplashScreen(),
    );
  }
}
