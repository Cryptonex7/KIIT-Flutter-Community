import 'package:flutter/material.dart';
import 'package:blogpost/models/post.dart';
import 'package:blogpost/shared/constants.dart';

class BlogBody extends StatelessWidget {
  final Post post;
  BlogBody({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        elevation: 6.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            'KIIT TODAY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                post.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                post.subtitle,
                style: kSubtitleTextStyle.copyWith(fontSize: 16),
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.person),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      post.author,
                      style: kSubtitleTextStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      post.date,
                      textDirection: TextDirection.rtl,
                      style: kSubtitleTextStyle.copyWith(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Hero(
              tag: 'view_image_${post.tag}',
              child: Image(
                image: AssetImage(
                    'images/blog_images/image${post.genre}_${post.tag}.png'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: RichText(
                text: TextSpan(
                  text: 'What this article is about?\n',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n${post.body}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
