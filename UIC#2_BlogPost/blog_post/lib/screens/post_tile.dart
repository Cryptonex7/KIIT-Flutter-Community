import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blogpost/models/post.dart';
import 'package:blogpost/screens/small_tile.dart';
import 'package:blogpost/screens/bigTile.dart';

class PostTile extends StatefulWidget {
  final Post post;
  PostTile({this.post});
  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    if (widget.post.size == 1) {
      return SmallTile(post: widget.post);
    } else {
      return BigTile(post: widget.post);
    }
  }
}
