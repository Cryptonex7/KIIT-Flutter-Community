import 'package:blog_news/models/posts.dart';

class User {
  List<Post> bookmarks = [];

  addBookmark(Post post) {
    bookmarks.add(post);
  }
}