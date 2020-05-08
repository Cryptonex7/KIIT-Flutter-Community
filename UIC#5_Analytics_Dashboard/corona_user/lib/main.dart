
import 'package:corona_user/screeens/details.dart';
//import 'package:corona_user/screeens/homeScreen.dart';
import 'package:flutter/material.dart';

import './screeens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona_India',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.black38,
        backgroundColor: Colors.black87,
      ),
      home: SplashScreen(),
      routes: {
        //HomeScreen.routeName : (ctx) => HomeScreen(),
        Details.routeName : (ctx) => Details(),
      },
    );
  }
}
