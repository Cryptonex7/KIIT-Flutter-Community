import 'package:corona_user/models/chartHTTP.dart';
import 'package:corona_user/models/statewise.dart';
import 'package:corona_user/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StateDetailsPage extends StatefulWidget {
  StateDetailsPage({this.data});

  final Map data;

  @override
  State<StatefulWidget> createState() {
    return StateDetailsPageState();
  }
}

class StateDetailsPageState extends State<StateDetailsPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  TextEditingController _textEditingController = TextEditingController();
  String searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    //var chartData = widget.data;
    var data = widget.data["statewise"].sublist(1);
    final List<StateWise> chartData = [];
    widget.data["statewise"].sublist(1, 11).forEach((element) {
      chartData.add(StateWise(
          active: element['active'], stateCode: element['statecode']));
    });
    return Scaffold(
        backgroundColor: Colors.black87,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            expandedHeight: 230,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(0),
              // title: ,
              background: Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                child: Chart(
                  data: chartData,
                  title: 'Top 10 Affected States',
                ),
              ),
            ),
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            pinned: true,
            actions: <Widget>[],
            actionsIconTheme: IconThemeData(),
            title: Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 0.07 * MediaQuery.of(context).size.height,
                child: TextField(
                  controller: _textEditingController,
                  cursorColor: Colors.white70,
                  // autofocus: true,
                  enableInteractiveSelection: true,
                  enableSuggestions: true,
                  textAlign: TextAlign.center,
                  showCursor: true,
                  cursorRadius: Radius.circular(15),
                  cursorWidth: 5,
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.quicksand(color: Colors.white),
                    labelText: "Search State",
                    fillColor: Colors.grey[900],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 2, color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 3, color: Colors.white70),
                    ),
                  ),
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 17,
                    //fontWeight: FontWeight.w500,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchKeyWord = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (!(searchKeyWord.trim() == "" ||
                  data[index]["state"].toLowerCase().contains(searchKeyWord)))
                return Container();

              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 10,
                  color: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[index]["state"],
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Confirmed",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["confirmed"]}".padLeft(7),
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recovered",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["recovered"]}".padLeft(7),
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Deaths",
                              style: GoogleFonts.quicksand(
                                fontSize: 17,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              "${data[index]["deaths"]}".padLeft(7),
                              style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: widget.data["statewise"].length - 1,
          ))
        ]));
  }
}
