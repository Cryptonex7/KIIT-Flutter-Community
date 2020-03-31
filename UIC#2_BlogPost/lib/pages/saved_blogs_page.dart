import 'package:college_news_blog/models/blog.dart';
import 'package:college_news_blog/widgets/saved_news_card.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SavedBlogPage extends StatefulWidget {
  @override
  _SavedBlogPageState createState() => _SavedBlogPageState();
}

class _SavedBlogPageState extends State<SavedBlogPage> {

  List<Blog> savedPosts;
  bool isLoaded = false;

  Future<List<Blog>> posts() async {
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
    final List<Map<String, dynamic>> maps = await db.query('blogs');

    return List.generate(maps.length, (i) {
      return Blog(
        blogTitle: maps[i]['blogTitle'],
        blogSubtitle: maps[i]['blogSubtitle'],
        blogBody: maps[i]['blogBody'],
        blogImage: maps[i]['blogImage'],
        date: maps[i]['date']
      );
    });
  }

  setSavedPosts() async {
    savedPosts = await posts();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    savedPosts = List();
    setSavedPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: DynamicTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
        ),
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        title: Text('Saved News',
          style: TextStyle(
            color: DynamicTheme.of(context).data.textTheme.subtitle.color
          ), 
        ),
      ),
      body: isLoaded
        ? ListView.builder(
          itemCount: savedPosts.length,
          itemBuilder: (context, index) {
            return SavedNewsCard(
              savedPosts[index].blogTitle, 
              savedPosts[index].blogSubtitle,
              savedPosts[index].blogImage,
              savedPosts[index].blogBody,
              savedPosts[index].date
            );
          },
        )
        :
        Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}