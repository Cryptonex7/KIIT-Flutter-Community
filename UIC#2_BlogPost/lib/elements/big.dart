import 'dart:collection';
import 'package:blog_news/elements/textStyles.dart';
import 'package:blog_news/models/posts.dart';
import 'package:blog_news/models/user.dart';
import 'package:blog_news/screens/postspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BigCard extends StatefulWidget {
  const BigCard({
    Key key,
    @required this.posts,
    @required this.user,
  }) : super(key: key);
  final User user;
  final HashMap<int, Post> posts;
  @override
  _BigCardState createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {

  Icon bookmark = Icon(Icons.bookmark_border);
  bool bookmarked = false;

  void toggleBookmark() {
    setState(() {
      if(!bookmarked) {
        bookmarked = true;
      } else {
        bookmarked = false;
      }
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 2.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 270.0,
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child:new Swiper(
          onTap: (value) =>  Navigator.push(context, MaterialPageRoute(
            builder: (context) => PostPage(post: widget.posts[value]))),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height:160,
                    width: 280.0,
                    color: Colors.black,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Tech Bits'),
                        ),
                        SizedBox(
                          height: 10.0,
                          child: Divider(
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.posts[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(width: 20),
                              Image.network(
                                widget.posts[index].imageUrl,
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Published on: ' + widget.posts[index].publishedAt.substring(0,10),
                          style: dateStyle
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: 3,
          viewportFraction: 0.8,
          scale: 1,
        )
      ),
    );
  }
}