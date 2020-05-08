import 'package:corona_user/screeens/details.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, Details.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 50,),
            Text('#indiafightscorona',style:GoogleFonts.aclonica(color: Colors.white,fontSize: 30),),
            SizedBox(height: 10,),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
            ),
            Container(
              padding: EdgeInsets.all(0),
              height: 250,
              width: double.infinity,
              child: Image.asset('assets/c19.png',fit: BoxFit.cover,),
            ),
          ],
        ),
      ),
    );
  }
}
