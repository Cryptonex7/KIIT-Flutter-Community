import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_news_blog/pages/saved_blogs_page.dart';
import 'package:college_news_blog/widgets/news_card.dart';
import 'package:college_news_blog/widgets/small_news_card.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/news_card.dart';
import './post_blog/blog_post_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSmall = false, isBig = false, isBoth = true;
  bool _isVisible = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  _getDefaults() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      this.isBoth = shared.getBool('isBoth') ?? true;
      this.isSmall = shared.getBool('isSmall') ?? false;
      this.isBig = shared.getBool('isBig') ?? false;
    });
  }

  @override
  void initState() {
    _getDefaults();
    super.initState();
  }

  _getBothCardList(AsyncSnapshot snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, i) {
        return i % 3 == 0
            ? AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: 1.0,
                child: SmallNewsCard(
                  title: snapshot.data.documents[i]['blog_title'],
                  subtitle: snapshot.data.documents[i]['blog_subtitle'],
                  image: snapshot.data.documents[i]['blog_image'],
                  body: snapshot.data.documents[i]['blog_body'],
                  date: snapshot.data.documents[i]['date'],
                ),
              )
            : AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: 1.0,
                child: NewsCard(
                  title: snapshot.data.documents[i]['blog_title'],
                  subtitle: snapshot.data.documents[i]['blog_subtitle'],
                  image: snapshot.data.documents[i]['blog_image'],
                  body: snapshot.data.documents[i]['blog_body'],
                  date: snapshot.data.documents[i]['date'],
                ),
              );
      },
    );
  }

  _getBigCardList(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.documents.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, i) {
        return NewsCard(
          title: snapshot.data.documents[i]['blog_title'],
          subtitle: snapshot.data.documents[i]['blog_subtitle'],
          image: snapshot.data.documents[i]['blog_image'],
          body: snapshot.data.documents[i]['blog_body'],
          date: snapshot.data.documents[i]['date'],
        );
      },
    );
  }

  _getSmallCardList(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.documents.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, i) {
        return SmallNewsCard(
          title: snapshot.data.documents[i]['blog_title'],
          subtitle: snapshot.data.documents[i]['blog_subtitle'],
          image: snapshot.data.documents[i]['blog_image'],
          body: snapshot.data.documents[i]['blog_body'],
          date: snapshot.data.documents[i]['date'],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "ColNews Blogger",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          fontFamily: 'Baloo'),
                    ),
                    Spacer(),
                    Icon(Icons.search),
                    SizedBox(
                      width: 14,
                    ),
                    Icon(Icons.notifications_active),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 8, right: 8),
                child: Text(
                  "Trending",
                  style: TextStyle(
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              NewsCard(
                title:
                    "Students suffering from fever, cold and cough due to heavy rain and change in weather",
                image: "https://static.toiimg.com/photo/72995118.cms",
                body:
                    "A sudden rainfall and change in weather in the night has caused the cold, fever and coughing to many students in the college. The college administration is willing to take strong action in this concern. This will continue if the students will not take care of themselves, said the hostel warden of KP-6. Many students are advised to get admitted in the hospital nearby to avoid the worst circumstances. ",
                subtitle:
                    "This is the effect of corona and this will continue if not taken care.",
                date: "16-March-2020",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Text(
                  "News Feed",
                  style: TextStyle(
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              StreamBuilder(
                stream: Firestore.instance
                    .collection('blog_posts')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (this.isBoth) {
                      return _getBothCardList(snapshot);
                    } else if (this.isSmall) {
                      return _getSmallCardList(snapshot);
                    } else if (this.isBig) {
                      return _getBigCardList(snapshot);
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/1.png'))),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      "John Doe",
                      style: TextStyle(
                          fontFamily: 'Baloo',
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Icon(
                Icons.perm_identity,
                color: Colors.red[300],
              ),
              title: Text(
                'My Profile',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.brightness_4,
                color: Colors.red[300],
              ),
              title: Theme.of(context).brightness == Brightness.light
                  ? Text("Enable Dark Theme",
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),)
                  : Text("Enable Light Theme",
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              onTap: () {
                _changeBrightness();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: Colors.red[300],
              ),
              title: Text('Saved News',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => SavedBlogPage()
                  )  
                );
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Text(
                'Layout Settings',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: Colors.red[300],
              ),
              title: Text('Big card',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              onTap: () async {
                SharedPreferences shared =
                    await SharedPreferences.getInstance();
                setState(() {
                  shared.setBool('isBig', true);
                  shared.setBool('isSmall', false);
                  shared.setBool('isBoth', false);
                  _getDefaults();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.chrome_reader_mode, color: Colors.red[300]),
              title: Text('Small card',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              onTap: () async {
                SharedPreferences shared =
                    await SharedPreferences.getInstance();
                setState(() {
                  shared.setBool('isSmall', true);
                  shared.setBool('isBig', false);
                  shared.setBool('isBoth', false);
                  _getDefaults();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_view_day,
                color: Colors.red[300],
              ),
              title: Text('Both',
                style: TextStyle(
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              onTap: () async {
                SharedPreferences shared =
                    await SharedPreferences.getInstance();
                setState(() {
                  shared.setBool('isBoth', true);
                  shared.setBool('isBig', false);
                  shared.setBool('isSmall', false);
                  _getDefaults();
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red[300],
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlogPostPage()));
          },
          label: Row(
            children: <Widget>[
              Icon(Icons.edit),
              SizedBox(
                width: 5,
              ),
              Text('Post a blog')
            ],
          )),
    );
  }
}
