// import 'package:charts_flutter/flutter.dart';
// import 'package:corona_user/models/statewise.dart';
// import 'package:corona_user/widgets/chart.dart';
// import 'package:corona_user/widgets/time_series_chart.dart';
import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:corona_user/screeens/states_details_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';


import '../models/httpAPI.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({this.data});

  final Map data;

  static const routeName = '/details';

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin{

AnimationController controller;
  Animation animation;
  Animation animationText;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 10,
      duration: Duration(
        seconds: 5,
      ),
    );

    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();}

  int totalConfirmedCases,
      totalRecoveredCases,
      totalDeceasedCases,
      totalActiveCases,
      deltaConfirmedCases,
      deltaRecoveredCases,
      deltaDeceasedCases;

  List<Widget> top7StatesActiveTextWidgets;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  Map futureData;
  String emptyScreenText = "Just a moment...";
  String failedSubText = "";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SmartRefresher(
        controller: _refreshController,
        header: TwoLevelHeader(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black87,
          ),
          textStyle: GoogleFonts.quicksand(
            fontSize: 15,
            color: Colors.white,
          ),
          idleIcon: Icon(
            Icons.arrow_downward,
            color: Colors.white,
          ),
          releaseIcon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          refreshingIcon: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          completeIcon: Icon(
            Icons.done,
            color: Colors.white,
          ),
          failedText: "No Internet Access$failedSubText",
          failedIcon: Icon(
            Icons.error,
            color: Colors.white,
          ),
          completeDuration: Duration(seconds: 2),
        ),
        enablePullDown: true,
        primary: true,
        onRefresh: () async {
          var data;
          var now = DateTime.now();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          try {
            data = await getFutureData();
            prefs.setString("last-loaded-data", json.encode(data));
            prefs.setString(
                "last-loaded-date", "${now.day}/${now.month}/${now.year}");
            _refreshController.refreshCompleted();
          } on SocketException {
            if (prefs.containsKey("last-loaded-date")) {
              setState(() {
                failedSubText =
                    "\nShowing results from ${prefs.getString("last-loaded-date")}";
              });
            }
            _refreshController.refreshFailed();
            if (prefs.containsKey("last-loaded-data")) {
              data = json.decode(prefs.getString("last-loaded-data"));
              print("Loading Old Data...");
            } else {
              setState(() {
                emptyScreenText = "No Internet!";
              });
            }
          }
          setState(() {
            futureData = data;
          });
        },
        child: Builder(builder: (BuildContext context) {
          if (futureData == null) {
            return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              strokeWidth: 5,
              ));
          }

          totalConfirmedCases =
              int.parse(futureData['statewise'][0]['confirmed']);
          totalRecoveredCases =
              int.parse(futureData['statewise'][0]['recovered']);
          totalDeceasedCases = int.parse(futureData['statewise'][0]['deaths']);
          totalActiveCases = int.parse(futureData['statewise'][0]['active']);

          deltaConfirmedCases =
              int.parse(futureData['statewise'][0]["deltaconfirmed"]);
          deltaRecoveredCases =
              int.parse(futureData['statewise'][0]["deltarecovered"]);
          deltaDeceasedCases =
              int.parse(futureData['statewise'][0]["deltadeaths"]);
              
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(width: 20.0, height: 30.0),
                  Text(
                    "#",
                    style: GoogleFonts.aclonica(
                        fontSize: 35.0, color: Colors.white),
                  ),
                  SizedBox(width: 20.0, height: 30.0),
                  RotateAnimatedTextKit(
                      totalRepeatCount: 100,
                      onTap: () {
                        print("Tap Event");
                      },
                      text: ["indiafightscorona", "stayhome", "staysafe"],
                      textStyle: GoogleFonts.aclonica(
                          fontSize: 30.0, color: Colors.white),
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ],
              ),
              //SizedBox(height: 15),
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 175,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        '${totalConfirmedCases * controller.value ~/ 10}',
                        style: GoogleFonts.quicksand(
                            color: Colors.white70, fontSize: 40),
                      ),
                      subtitle: Text(
                        'Total Cases',
                        style: GoogleFonts.quicksand(
                            color: Colors.white54, fontSize: 30),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.virus,
                        color: Colors.white70,
                        size: 70,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.only(left: 10,right:10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 175,
                    width: ((MediaQuery.of(context).size.width) / 2) - 10,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          '${totalDeceasedCases * controller.value ~/ 10}',
                          style: GoogleFonts.quicksand(
                              color: Colors.white70, fontSize: 40),
                        ),
                        subtitle: Text(
                          'Deaths',
                          style: GoogleFonts.quicksand(
                              color: Colors.white54, fontSize: 25),
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.skullCrossbones,
                          color: Colors.white70,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 10,right:10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 175,
                    width: ((MediaQuery.of(context).size.width) / 2) - 10,
                    child: Center(
                      child: ListTile(
                        title: Text(
                          '${totalRecoveredCases * controller.value ~/ 10}',
                          style: GoogleFonts.quicksand(
                              color: Colors.white70, fontSize: 30),
                        ),
                        subtitle: Text(
                          'Cured',
                          style: GoogleFonts.quicksand(
                              color: Colors.white54, fontSize: 25),
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.clinicMedical,
                          color: Colors.white70,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      height: 125,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Center(
                        child: ListTile(
                          title: Text(
                            '${totalActiveCases * controller.value ~/ 10}',
                            style: GoogleFonts.quicksand(
                                color: Colors.white70, fontSize: 35),
                          ),
                          subtitle: Text(
                            'Active',
                            style: GoogleFonts.quicksand(
                                color: Colors.white54, fontSize: 25),
                          ),
                          trailing: Icon(
                                FontAwesomeIcons.hospitalUser,
                            color: Colors.white70,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
              ListTile(
                contentPadding: EdgeInsets.only(left:50,right:50),
                  title: Text(
                    'See State-wise Data',
                    style: GoogleFonts.quicksand(
                        color: Colors.white70, fontSize: 25),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return StateDetailsPage(data: futureData);
                        },
                      ),
                    );
                  }),
            ],
          );
        }),
      ),
    );
  }
}
