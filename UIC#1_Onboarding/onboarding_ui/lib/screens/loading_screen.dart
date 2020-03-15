import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getHomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('flag') || (prefs.getBool('flag') == true)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    } else {
      prefs.setBool('flag', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnboardingScreen();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
