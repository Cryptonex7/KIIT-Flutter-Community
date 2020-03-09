import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed('/onboard');
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1800), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {

    var introImage = Image.asset('images/intro.png');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            introImage,
            Text(
              "Welcome...",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
