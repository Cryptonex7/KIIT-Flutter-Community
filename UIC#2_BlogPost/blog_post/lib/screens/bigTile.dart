import 'package:flutter/material.dart';
import 'package:blogpost/models/post.dart';
import 'package:blogpost/shared/offline_data.dart';
import 'package:blogpost/screens/blog_body.dart';
import 'package:blogpost/shared/constants.dart';

class BigTile extends StatefulWidget {
  final Post post;
  BigTile({this.post});

  @override
  _BigTileState createState() => _BigTileState();
}

class _BigTileState extends State<BigTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogBody(
              post: widget.post,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 4,
          margin: EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Hero(
                  tag: 'view_image_${widget.post.tag}',
                  child: Image(
                    image: AssetImage(
                        'images/blog_images/image${widget.post.genre}_${widget.post.tag}.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kTitleTextStyle,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      widget.post.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: kSubtitleTextStyle,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${widget.post.author}'),
                          SizedBox(height: 3.0),
                          Text(
                            '${widget.post.date}',
                            style: kSubtitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          if (widget.post.genre == 1 &&
                              !edu.containsKey(widget.post.tag))
                            edu[widget.post.tag] = widget.post;
                          else if (widget.post.genre == 2 &&
                              !cul.containsKey(widget.post.tag))
                            cul[widget.post.tag] = widget.post;
                          else if (widget.post.genre == 3 &&
                              !spo.containsKey(widget.post.tag))
                            spo[widget.post.tag] = widget.post;
                        });
                      },
                      child: Icon(
                        Icons.file_download,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
