import 'package:blog_news/elements/textStyles.dart';
import 'package:blog_news/models/posts.dart';
import 'package:blog_news/models/user.dart';
import 'package:blog_news/screens/postspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SmallCard extends StatefulWidget {
  const SmallCard({
    Key key,
    @required this.post,
    @required this.user,
  }) : super(key: key);
  final User user;
  final Post post;
  @override
  _SmallCardState createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> with AutomaticKeepAliveClientMixin<SmallCard>{

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
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 2.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => PostPage(post: widget.post))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 170.0,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.post.title,
                  maxLines: 1,
                  style: titleStyle,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Row(
                  children: <Widget>[
                    Image.network(widget.post.imageUrl, height: 100.0, width: 100.0),
                    SizedBox(width: 20.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.post.source,
                            style: contentStyle,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            widget.post.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'By: ' + widget.post.author,
                            style: dateStyle,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Published on: ' + widget.post.publishedAt.substring(0,10),
                            style: dateStyle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 100.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            padding: EdgeInsets.all(0.0),
                            icon: (bookmarked) ? Icon(Ionicons.ios_bookmark, color: Colors.red,) : Icon(Ionicons.ios_bookmark), 
                            onPressed: () {
                              toggleBookmark();
                              widget.user.addBookmark(widget.post);
                            }
                          ),
                        ),
                        SizedBox(width:20.0),
                        SizedBox(
                          height: 18,
                          width: 20,
                          child: IconButton(
                            iconSize: 21.0,
                            splashColor: Colors.transparent,
                            padding: EdgeInsets.all(0.0),
                            icon: Icon(AntDesign.download),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}