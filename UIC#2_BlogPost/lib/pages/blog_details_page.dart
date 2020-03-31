import 'dart:math';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailsPage extends StatelessWidget {
  final String title, body, image, subtitle, date;
  final int likes, views;

  BlogDetailsPage({
    this.title,
    this.body,
    this.image,
    this.subtitle,
    this.date,
    this.likes,
    this.views
  });

  generateRandomNumer() {
    int min = 0, max = 4;
    Random rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  List<String> assetImages = [
    'assets/images/1.png',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[300],
        child: Icon(Icons.share),
        onPressed: () {
          
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red[300],
            centerTitle: true,

            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.red[300],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            expandedHeight: deviceHeight * 0.31,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              background: this.image != null
                ? Image.network(this.image, fit: BoxFit.fill) : Image.asset(assetImages[generateRandomNumer()]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Chip(
                              backgroundColor: DynamicTheme.of(context).data.cardColor,
                              avatar: Icon(Icons.access_time, color: Colors.red[300]),
                              label: Text(
                                this.date,
                                style: TextStyle(
                                  color: DynamicTheme.of(context).data.textTheme.subtitle.color
                                ),
                              ),
                            ),
                            Spacer(),
                            Chip(
                              backgroundColor: DynamicTheme.of(context).data.cardColor,  
                              avatar: Icon(Icons.favorite, color: Colors.red[300],),
                              label: Text(
                                "${this.likes} likes",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: DynamicTheme.of(context).data.textTheme.subtitle.color
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo',
                            height: 1.2
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Html(
                          data: """${this.body}""",
                          defaultTextStyle: TextStyle(
                            //color: DynamicTheme.of(context).data.cardColor,
                            fontSize: 18.0,
                            fontFamily: 'Baloo',
                            height: 1.0
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: 1
            ),
          )
        ],
      ),
    );
  }
}