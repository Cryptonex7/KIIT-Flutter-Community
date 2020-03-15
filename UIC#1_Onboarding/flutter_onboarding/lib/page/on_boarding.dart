import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyOnBoardingPages extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyOnBoardingPagesState createState() => _MyOnBoardingPagesState();
}

class _MyOnBoardingPagesState extends State<MyOnBoardingPages> {
  PageController pageViewController = PageController(viewportFraction: 0.99);
  var pages = <Widget>[
    OnBoardingPage(
      message: "Events Management has never been so easy.",
      imageName: "445925-PF89TC-375.jpg",
    ),
    OnBoardingPage(
      message: "Team work at its best.",
      imageName: "456341-PFGP9Q-332.jpg",
    ),
    OnBoardingPage(
      message: "Timely notifications helps you and your team miss nothing.",
      imageName: "2785427.jpg",
    ),
  ];
  String skipButtonText = "Skip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageViewController,
            onPageChanged: _onPageViewChange,
            children: pages,
            physics: BouncingScrollPhysics(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: SmoothPageIndicator(
              count: pages.length,
              controller: pageViewController,
              effect: ExpandingDotsEffect(
                expansionFactor: 3,
              ),
            ),
          ),
          Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.26,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: FlatButton(
                    color: Colors.black12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          skipButtonText,
                          style: TextStyle(
                              fontSize: 20, color: Colors.blue.shade700),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue.shade700,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }

  _onPageViewChange(int page) {
    if (page == pages.length - 1) {
      setState(() {
        skipButtonText = "Done";
      });
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  // This Widget will appear as the Pages of PageView

  // Constructor
  OnBoardingPage({this.message, this.imageName});

  final String message, imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0, 6, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("images/" + imageName),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
