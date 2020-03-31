import 'package:college_news_blog/pages/post_blog/blog_image_upload.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';
import 'package:quill_delta/quill_delta.dart';

class BlogPostPage extends StatefulWidget {
  @override
  _BlogPostPageState createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {

  ZefyrController _controller;

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.5,
        centerTitle: false,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Title goes here',
          ),
        ),
      ),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          controller: _controller, 
          focusNode: _focusNode,
          padding: EdgeInsets.all(15),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogImageUpload()
            )
          );
        },
      ),
    );
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert('Write here\n');
    return NotusDocument.fromDelta(delta);
  }
}