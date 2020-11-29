import 'package:blogpost/screens/post_list.dart';
import 'package:blogpost/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogpost/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final List imgList = [
  'images/appbar_bg/library.jpeg',
  'images/appbar_bg/cultural.jpg',
  'images/appbar_bg/sports.jpg'
];

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DatabaseService db = DatabaseService();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();

    _tabController.addListener(() {
      setState(() {});
      db.index = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: db.posts,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: AppBar(
            elevation: 6.0,
            backgroundColor: Colors.white70,
            title: Text('Blogs'),
            flexibleSpace: Opacity(
              opacity: 0.7,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: imgList.map((img) {
                  return Image(
                    image: AssetImage(img),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    icon: Image(
                      image: AssetImage('images/tab_icons/book.png'),
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ),
                    text: 'educational'),
                Tab(
                    icon: Image(
                      image: AssetImage('images/tab_icons/dancer.png'),
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ),
                    text: 'cultural'),
                Tab(
                    icon: Image(
                      image: AssetImage('images/tab_icons/swim.png'),
                      height: 25,
                      width: 25,
                      color: Colors.white,
                    ),
                    text: 'sports'),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
          ),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              PostList(),
              PostList(),
              PostList(),
            ],
          ),
        ),
      ),
    );
  }
}
