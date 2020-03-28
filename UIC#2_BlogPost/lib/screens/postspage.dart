import 'package:blog_news/elements/textStyles.dart';
import 'package:blog_news/models/posts.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  PostPage({this.post});
  final Post post;
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  widget.post.title,
                  style: headlineStyle,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 40.0),
                Image.network(widget.post.imageUrl),
                SizedBox(height: 20.0),
                Text(
                  'By: ' + widget.post.author,
                  style: authorStyle,
                ),
                SizedBox(height: 20.0),                
                Text(
                  'Published on: ' + widget.post.publishedAt.substring(0,10),
                  style: dateStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.post.source,
                  style: titleStyle,
                ),
                SizedBox(
                  height: 40.0,
                  width: 250.0,
                  child: Divider(
                    thickness: 2.0,
                  ),
                ),
                Text(widget.post.content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}