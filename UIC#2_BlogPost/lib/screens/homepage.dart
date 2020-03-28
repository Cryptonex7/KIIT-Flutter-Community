import 'dart:collection';

import 'package:blog_news/elements/big.dart';
import 'package:blog_news/elements/colors.dart';
import 'package:blog_news/elements/small.dart';
import 'package:blog_news/models/posts.dart';
import 'package:blog_news/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.posts, @required this.user, this.techposts}) : super(key: key);
  final List<Post> posts;
  final User user;
  final HashMap<int, Post> techposts;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  List<Post> localposts = [];
  List<HashMap> batch = new List<HashMap>();
  int i=0;

  Future<Null> _refresh() {
    return fetchPost().then((_posts) {
      setState(() {
        localposts = _posts;
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    setState(() {
      localposts = widget.posts;
    });
    HashMap<int, Post> first = new HashMap();
    HashMap<int, Post> second = new HashMap();
    HashMap<int, Post> third = new HashMap();
    for(int i=0; i<3; i++) {
      first[i] = widget.techposts[i];
      second[i] = widget.techposts[i+3];
      third[i] = widget.techposts[i+6];
    }
    batch.add(first);
    batch.add(second);
    batch.add(third);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(
            color: getColor(context), 
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: widget.posts.isNotEmpty ? 
        ListView.builder(
          itemCount: 11,
          itemBuilder: (BuildContext context, int index) {
            if(index%4 != 0) return SmallCard(post: localposts[index], user: widget.user,);
            else return BigCard(posts: batch[index%3], user: widget.user);
          }
        ) : Container(
          child: Center(
            child: SvgPicture.asset(
              'assets/nothing.svg',
              height: 200.0,
              width: 200.0,
            ),
          ),
        )
      )
    );
  }
}