import 'package:corona_user/models/statewise.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';

class Chart extends StatelessWidget {
  final List<StateWise> data;

  final String title;

  Chart({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<StateWise, String>> items = [
      charts.Series(
        fillColorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        id: 'confirmed',
        data: data,
        domainFn: (StateWise items, _) => items.stateCode,
        measureFn: (StateWise items, _) => int.parse(items.active),
      )
    ];

    if (data == null)
      return Center(child: CircularProgressIndicator());
    else
      return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft:
                Radius.elliptical(MediaQuery.of(context).size.width / 2, 60),
            bottomRight:
                Radius.elliptical(MediaQuery.of(context).size.width / 2, 60)),
        child: Container(
          padding: EdgeInsets.all(0),
          color: Colors.white,
          height: 250,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                height: 200,
                child: charts.BarChart(
                  items,
                  animate: true,
                  defaultRenderer: new charts.BarRendererConfig(
                      cornerStrategy: const charts.ConstCornerStrategy(30)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.quicksand(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
