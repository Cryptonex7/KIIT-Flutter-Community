 import 'dart:async';
import 'dart:collection';
import 'package:blog_news/models/posts.dart';
import 'package:blog_news/models/user.dart';
import 'package:blog_news/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
   @override
   _SplashScreenState createState() => _SplashScreenState();
 }
 
 class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState(){
     super.initState();
     List<Post> posts = [];
     fetchPost().then((_posts) {
       posts.addAll(_posts);
    });
    HashMap<int, Post> techposts;
    fetchTechPost().then((_techposts) {
       techposts = _techposts;
    });
    User user = new User();
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(builder: (context) => 
      HomePage(posts: posts, user: user, techposts: techposts));
      Navigator.pushReplacement(context, route);
    });
  }
   
   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Stack(
           fit: StackFit.expand,
           children: <Widget>[
             Container(
               decoration: BoxDecoration(
                 color: Theme.of(context).backgroundColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   'News',
                  //   style: TextStyle(
                  //     color:getColor(context),
                  //     fontSize: 30.0,
                  //     fontWeight: FontWeight.bold,
                  //     fontFamily: 'ShadowsIntoLight',
                  //     letterSpacing: 3.0
                  //   ),
                  // ),
                  SizedBox(height: 50.0),
                  SvgPicture.asset(
                    'assets/news.svg',
                    height: 100.0,
                    width: 100.0,
                  )
                ],
              ),
            ],
         ),
       ),
     );
   }
 }