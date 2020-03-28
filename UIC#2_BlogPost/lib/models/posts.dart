import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {

  String source;
  String author;
  String title;
  String description;
  String url;
  String imageUrl;
  String publishedAt;
  String content;

  Post({this.source, this.author, this.title, 
    this.description, this.url, this.imageUrl, this.publishedAt, this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      source: json['source']['name'].toString(),
      author: json['author'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      url: json['link'].toString(),
      imageUrl: json['urlToImage'].toString(),
      publishedAt: json['publishedAt'].toString(),
      content: json['content'].toString(),
    );
  }
}

  List<Post> _postList = new List<Post>();
  // List<Post> _techList = new List<Post>();
  int i = 0;
  HashMap<int, Post> _techPosts = new HashMap();

  Future<HashMap> fetchTechPost() async {
    final respnse = await http.get('http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5c5b88e1c1594806858b44985fc7fde7');
    if(respnse.statusCode == 200) {
      var values;
      values = json.decode(respnse.body);
      values = values['articles'];
      if(values.length>0) {
        for(int i=0; i<values.length; i++) {
         if(values[i] != null) {
            Map<String,dynamic> map = values[i];
            _techPosts[i] = Post.fromJson(map) ;
          }
        }
      } else {
        throw Exception('Failed to load post');
      }
    }
    return _techPosts;
  }

  Future<List<Post>> fetchPost() async {
    // final firstRun =
    //   await http.get('http://newsapi.org/v2/everything?domains=wsj.com&apiKey=5c5b88e1c1594806858b44985fc7fde7');
    // var runValue = json.decode(firstRun.body);
    // int totalArticles = runValue['totalResults'];
    // print(totalArticles);
    
    for(int i=1; i<=5; i++) {
      final response =
      await http.get('http://newsapi.org/v2/everything?domains=wsj.com&apiKey=5c5b88e1c1594806858b44985fc7fde7&page=' + i.toString());

      if (response.statusCode == 200) {
        var values;
        values = json.decode(response.body);
        values = values['articles'];
        if(values.length>0){
          for(int j=0; j<values.length; j++){
            if(values[j] != null){
              Map<String,dynamic> map = values[j];
              _postList.add(Post.fromJson(map));
            }
          }
        }
      } else {
        throw Exception('Failed to load post');
      }
    }
    return _postList;
  }

  // Future<List<Post> > fetchNewPost() async {
  //   print(i/10);
  //   final response =
  //   await http.get('http://newsapi.org/v2/everything?domains=wsj.com&apiKey=5c5b88e1c1594806858b44985fc7fde7&page=' + (i/10).toString());

  //   if (response.statusCode == 200) {
  //     var value;
  //     value = json.decode(response.body);
  //     value = value['articles'];
  //     if(value.length>0){
  //         if(value[i%10]!=null){
  //           print(i);
  //           Map<String,dynamic> map=value[i++%10];
  //           _postList.insert(0,Post.fromJson(map));
  //       }
  //     }
  //     return _postList;

  //   } else {
  //     throw Exception('Failed to load post');
  //   }
  // }