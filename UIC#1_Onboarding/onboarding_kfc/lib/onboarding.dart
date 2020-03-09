import 'main.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:onboarding_kfc/hello.dart';

class OnBoarding extends StatelessWidget {

  final pages = [
    PageViewModel(
      pageColor: Colors.lightBlue,
      title: Text('KFC'),
      body: Text("Mainly started to make awareness of Competitve coding and OpenSource projects Among them."),
      mainImage: Image.asset("assets/bird.png",width: 330,height: 330,),
      titleTextStyle: TextStyle(fontFamily: "Montserrat-Bold", color: Colors.white ),
      bodyTextStyle: TextStyle(fontFamily: "Montserrat-Medium", color: Colors.white ),
    ),
    PageViewModel(
      pageColor: Colors.red[200],
      title: Text('Competitive Coding'),
      body: Text("Competitve Coding is essential for Placement"),
      mainImage: Image.asset("assets/bird.png",width: 250,height: 250,),
      titleTextStyle: TextStyle(fontFamily: "Montserrat-Bold", color: Colors.white ),
      bodyTextStyle: TextStyle(fontFamily: "Montserrat-Medium", color: Colors.white ),
    ),
    PageViewModel(
      pageColor: Colors.amber,
      title: Text('Open Source'),
      body: Text("Open-Source Contribution can Improve your Skills."),
      mainImage: Image.asset("assets/bird.png",width: 250,height: 250,),
      titleTextStyle: TextStyle(fontFamily: "Montserrat-Bold", color: Colors.white ),
      bodyTextStyle: TextStyle(fontFamily: "Montserrat-Medium", color: Colors.white ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => new IntroViewsFlutter(
        pages,
        showSkipButton: true,
        showNextButton: true,
        nextText: Icon(Icons.arrow_forward,color: Colors.white,),
        showBackButton: true,
        backText: Icon(Icons.arrow_back,color: Colors.white,),
        onTapDoneButton: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Hello()));
        },
        pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat-Medium"
        ),
      ),
    );
  }
}
