import 'package:flutter/material.dart';
import 'dart:math';
import '../pages/blog_details_page.dart';
import 'package:flutter_html/flutter_html.dart';

import '../widgets/slide_right_route.dart';

class SavedNewsCard extends StatefulWidget {
  final String title, subtitle, image, body, date;
  SavedNewsCard(this.title, this.subtitle, this.image, this.body, this.date);

  @override
  _SavedNewsCardState createState() => _SavedNewsCardState();
}

class _SavedNewsCardState extends State<SavedNewsCard> {
  int generateRandomNumber(int min, max) {
    Random rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  @override
  void initState() {
    views = generateRandomNumber(1, 1000);
    likes = generateRandomNumber(1, views);
    super.initState();
  }

  int views, likes;

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              SlideRightRoute(
                  page: BlogDetailsPage(
                body: widget.body,
                title: widget.title,
                subtitle: widget.subtitle,
                date: widget.date,
                image: widget.image,
                likes: this.likes,
                views: this.views,
              )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            this.widget.image != null
                ? Stack(
                    children: <Widget>[
                      Container(
                        height: deviceHeight * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(this.widget.image))),
                      ),
                      Container(
                        height: deviceHeight * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.center,
                                colors: [
                                  Colors.black.withOpacity(0.55),
                                  Colors.black.withOpacity(0.15)
                                ],
                                stops: [
                                  0.5,
                                  3.8
                                ])),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.125,
                                    left: 8.0,
                                    right: 8.0),
                                child: Html(
                                  data: this.widget.title,
                                  useRichText: true,
                                  defaultTextStyle: TextStyle(
                                      height: 1.25,
                                      fontSize: deviceHeight * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Baloo'),
                                ))
                          ],
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                    child: Html(
                      data: this.widget.title,
                      defaultTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceHeight * 0.023,
                          color: Colors.black),
                    ),
                  ),
            SizedBox(
              height: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                this.widget.subtitle != null ? this.widget.subtitle : this.widget.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: deviceHeight * 0.02, fontFamily: 'Baloo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "${this.views} views | ",
                        style:
                            TextStyle(fontFamily: 'Baloo', color: Colors.red),
                      ),
                      Text(
                        "${this.likes} likes",
                        style:
                            TextStyle(fontFamily: 'Baloo', color: Colors.red),
                      )
                    ],
                  ),
                  Text(
                    this.widget.date,
                    style: TextStyle(fontFamily: 'Baloo', color: Colors.red),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
