import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onboarding_ui/constants.dart';
import 'package:onboarding_ui/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  double _width = 200;
  double _height = 200;

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation =
        ColorTween(begin: Colors.amber, end: kDarkBlue).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView(
              physics: ClampingScrollPhysics(),
              onPageChanged: (int page) {
                _currentPage = page;
                setState(() {
                  controller = AnimationController(
                      duration: Duration(seconds: 1), vsync: this);

                  if (_currentPage == 0) {
                    animation = ColorTween(begin: Colors.amber, end: kDarkBlue)
                        .animate(controller);
                  } else if (_currentPage == 1) {
                    animation =
                        ColorTween(begin: Colors.tealAccent, end: kDarkBlue)
                            .animate(controller);
                  } else if (_currentPage == 2) {
                    animation = ColorTween(
                            begin: Colors.purpleAccent[100], end: kDarkBlue)
                        .animate(controller);
                  }

                  controller.forward();

                  controller.addListener(() {
                    setState(() {});
                  });
                });
              },
              controller: _controller,
              children: <Widget>[
                Container(
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: SvgPicture.asset(
                          'images/online_articles.svg',
                          width: _width,
                          height: _height,
                          alignment: Alignment(0, 1),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Online Articles',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Publish online Articles to internet',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.tealAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: SvgPicture.asset(
                          'images/online_payments.svg',
                          width: _width,
                          height: _height,
                          alignment: Alignment(0, 1),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Online Payments',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Do online payments seamlessly',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.purpleAccent[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: SvgPicture.asset(
                          'images/online_posts.svg',
                          width: _width,
                          height: _height,
                          alignment: Alignment(0, 1),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Online Posts',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 42.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'See online posts with ease',
                                style: TextStyle(
                                  color: animation.value,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 35),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 3; i++)
                        if (i == _currentPage)
                          circleBar(true)
                        else
                          circleBar(false),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 25.0,
              bottom: 25.0,
              child: Visibility(
                visible: _currentPage == 2 ? true : false,
                child: FloatingActionButton.extended(
                  label: Text('Next'),
                  backgroundColor: Colors.deepPurpleAccent,
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    });
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            Positioned(
              right: 20.0,
              top: 40.0,
              child: Visibility(
                  visible: _currentPage == 2 ? false : true,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius:
                                5.0, // has the effect of softening the shadow
                            offset: Offset(
                              4.0, // horizontal, move right 10
                              4.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.green.shade400 : Colors.green.shade900,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
