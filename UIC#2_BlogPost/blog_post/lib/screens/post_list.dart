import 'package:blogpost/models/post.dart';
import 'package:blogpost/screens/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    var posts = Provider.of<List<Post>>(context) ?? [];
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 15.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostTile(post: posts[index]);
      },
    );
  }
}
