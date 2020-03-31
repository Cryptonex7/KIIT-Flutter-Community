import 'package:college_news_blog/pages/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class BlogImageUpload extends StatefulWidget {
  @override
  _BlogImageUploadState createState() => _BlogImageUploadState();
}

class _BlogImageUploadState extends State<BlogImageUpload> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File file;
  String fileName = '';
  bool isUploaded = false;
  String downloadUrl = '';
  bool isLoaded = false;
  bool isUploading = false;

  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    storageReference = FirebaseStorage.instance.ref().child('blog_images/$filename');
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    setState(() {
      isUploaded = true;
      this.downloadUrl = url;
    });
    print('URL is $url');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage()
      )
    );
  }

  Future filePicker() async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
      setState(() {
        fileName = p.basename(file.path);
        isLoaded = true;
      });
      
    } on PlatformException catch(e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sorry...'),
            content: Text('Unsupported exception: $e'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
        iconTheme: IconThemeData(
          color: DynamicTheme.of(context).data.iconTheme.color
        ),
        centerTitle: true,
        title: Text('Image Upload', style: TextStyle(fontFamily: 'Baloo', fontSize: 23, fontWeight: FontWeight.bold, color: DynamicTheme.of(context).data.textTheme.subtitle.color),),
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: deviceHeight * 0.05,),
            this.isLoaded ? Image.file(file, height: deviceHeight * 0.5,) : Image.asset('assets/images/cloud.png', height: deviceHeight * 0.4),
            this.isLoaded ? 
              SizedBox() 
              : 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                child: RaisedButton(
                color: Colors.red[400],
                child: Text('Choose from file', style: TextStyle(fontFamily: 'Baloo', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
                onPressed: filePicker,
            ),
              ),
            SizedBox(height: deviceHeight * 0.075,),
            this.isLoaded ? 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: RaisedButton(
                  color: Colors.red[400],
                  child: Text(
                    this.isUploading ? "Uploading..." : 'Upload',
                    style: TextStyle(
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ), 
                  onPressed: () {
                    setState(() {
                      this.isUploading = true;
                    });
                    _uploadFile(file, fileName);
            },),
              )
            : SizedBox()
          ],
        ),
      ),
    );
  }
}