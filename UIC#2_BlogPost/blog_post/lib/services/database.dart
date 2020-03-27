import 'package:blogpost/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  int index = 0;

  final CollectionReference postCollection =
      Firestore.instance.collection('posts');

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
//      print(doc.data);
      String date = DateFormat.yMMMMd("en_US")
          .format(DateTime.parse(doc.data['date'].toDate().toString()));
      String body = doc.data['body'] ?? '';
      body = body.replaceAll('\\n', '\n');
      return Post(
          title: doc.data['title'] ?? '',
          subtitle: doc.data['subtitle'] ?? '',
          body: body,
          size: doc.data['size'] ?? 1,
          tag: doc.data['tag'] ?? 1,
          genre: doc.data['genre'] ?? 1,
          author: doc.data['author'] ?? '',
          date: date);
    }).toList();
  }

  // get brews stream
  Stream<List<Post>> get posts {
    if (index == 0)
      return postCollection
          .document('educational_posts')
          .collection('posts')
          .snapshots()
          .map(_postListFromSnapshot);
    else if (index == 1)
      return postCollection
          .document('cultural_posts')
          .collection('posts')
          .snapshots()
          .map(_postListFromSnapshot);
    else
      return postCollection
          .document('sports_post')
          .collection('posts')
          .snapshots()
          .map(_postListFromSnapshot);
  }
}
