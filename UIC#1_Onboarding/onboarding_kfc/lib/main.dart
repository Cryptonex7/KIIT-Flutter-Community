import 'package:flutter/material.dart';
import 'package:onboarding_kfc/hello.dart';
import 'package:onboarding_kfc/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      home: new Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Hello()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 2000), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              new Divider(height: 100,color: Colors.white,),
              new Image.asset("assets/bird.png",height: 300,width: 300,),
              new Divider(height: 100,color: Colors.white,),
              new Stack(
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                  ),
                  Center(child:Text("KIIT KFC",style: new TextStyle(fontFamily: "Montserrat-Medium",color: Colors.white,fontSize: 50,letterSpacing: 1)),)
                ],
              ),
              new Divider(height: 20,color: Colors.white,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("WELCOME",style: new TextStyle(fontFamily: "Montserrat-Medium",color: Colors.black,fontSize: 30,letterSpacing: 1)),
                  new Icon(
                    Icons.arrow_forward,size: 40,color: Colors.blue,
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

