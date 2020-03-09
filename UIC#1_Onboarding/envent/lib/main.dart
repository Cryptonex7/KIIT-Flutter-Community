import 'package:flutter/material.dart';

import 'package:envent/files/overboard.dart';
import 'package:envent/files/page_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Envent - Manages like god'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Skip clicked"),
          ));
        },
        finishCallback: () {
          _globalKey.currentState.showSnackBar(SnackBar(
            content: Text("Finish clicked"),
          ));
        },
      ),
    );
  }

  final pages = [
        PageModel(
            color: const Color(0xFFFFFFFF),
            imageAssetPath: 'images/img1.png',
            title: 'Hello',
            body: 'Welcome to Envent',
            doAnimateImage: true),
        PageModel(
            color: const Color(0xFFFFFFFF),
            imageAssetPath: 'images/img2.png',
            title: 'Least Price Gurantee',
            body: 'Let us manage your event at least cost.',
            doAnimateImage: true),
        PageModel(
            color: const Color(0xFFFFFFFF),
            imageAssetPath: 'images/img3.png',
            title: 'Popularity!!!',
            body: 'Most popular company of the year.',
            doAnimateImage: true),
        PageModel.withChild(
            child: Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: Image.asset('images/img2.png', width: 300.0, height: 300.0),
            ),
            color: const Color(0xFFFFFFFF),
            doAnimateChild: true)
  ];
}