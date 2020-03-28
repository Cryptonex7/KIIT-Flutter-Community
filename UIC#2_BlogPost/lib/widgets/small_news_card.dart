import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:share/share.dart';
import '../pages/blog_details_page.dart';
import 'package:path/path.dart' as p;

import '../widgets/slide_right_route.dart';
import '../models/blog.dart';

class SmallNewsCard extends StatefulWidget {
  final String title, subtitle, image, body, date, id;
  SmallNewsCard({this.id, this.title, this.subtitle, this.image, this.body, this.date});

  @override
  _SmallNewsCardState createState() => _SmallNewsCardState();
}

class _SmallNewsCardState extends State<SmallNewsCard> {
  int generateRandomNumber(int min, max) {
    Random rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  Future _savePost() async {

    Blog blog = new Blog(
      blogTitle: widget.title,
      blogBody: widget.body,
      blogImage: widget.image,
      blogSubtitle: widget.subtitle,
      date: widget.date,
    );

    final Future<Database> database = openDatabase(
      p.join(await getDatabasesPath(), 'colnewsblogger.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE blogs(blogTitle TEXT, blogSubtitle TEXT, blogBody TEXT, blogImage TEXT, date TEXT)"
        );
      },
      version: 1
    );

    final Database db = await database;
    return db.insert(
      'blogs',
      Blog.toMap(blog),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
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
    return Container(
      height: deviceHeight * 0.215,
      child: InkWell(
        onDoubleTap: () {
          if (!this.isLiked) {
            setState(() {
              this.likes++;
              this.isLiked = true;
            });
          } else {
            setState(() {
              this.likes--;
              this.isLiked = false;
            });
          }
        },
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
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(top: 0.0),
                    child: Column(
                      children: <Widget>[
                        new SizedBox(
                          height: deviceHeight * 0.2025,
                          width: 130,
                          child: new Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 7.5,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 7.5,
                    ),
                    Container(
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo',
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Text(
                        widget.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1, fontFamily: 'Baloo', fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${this.views.toString()} views",
                          style: TextStyle(
                              color: Colors.red[400],
                              fontFamily: 'Baloo',
                              height: 1),
                        ),
                        Spacer(),
                        Text(
                          widget.date,
                          style: TextStyle(
                              color: Colors.red[400],
                              fontFamily: 'Baloo',
                              height: 1),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: this.isLiked
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red[400],
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ),
                              onPressed: () {
                                if (!this.isLiked) {
                                  setState(() {
                                    this.isLiked = true;
                                    this.likes++;
                                  });
                                } else {
                                  setState(() {
                                    this.isLiked = false;
                                    this.likes--;
                                  });
                                }
                              },
                            ),
                            Text(
                              "${this.likes}",
                              style: TextStyle(
                                fontFamily: 'Baloo',
                                fontSize: 15
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          onPressed: () {
                            _savePost();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    elevation: 10,
                                    children: <Widget>[
                                      Center(
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Post Saved Successfully",
                                              style: TextStyle(
                                                color: DynamicTheme.of(context).data.textTheme.subtitle.color
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            RaisedButton(
                                              elevation: 0,
                                              child: Text(
                                                "OK",
                                                style:
                                                    TextStyle(color: Colors.red),
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                    backgroundColor: DynamicTheme.of(context).data.backgroundColor,
                                    title: Center(
                                      child: Text(
                                        'Post Saved',
                                        style: TextStyle(
                                          color: DynamicTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            Share.share(
                                "Hey read this news from ColNews Blogger: ${widget.title}");
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
