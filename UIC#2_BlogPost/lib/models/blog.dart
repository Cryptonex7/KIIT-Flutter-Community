
class Blog {
  final String blogTitle;
  final String blogSubtitle;
  final String blogImage;
  final String blogBody;
  final String date;

  Blog({this.blogTitle, this.blogSubtitle, this.blogImage, this.blogBody, this.date});

  static toMap(Blog blog) {
    return {
      'blogTitle': blog.blogTitle,
      'blogSubtitle': blog.blogSubtitle,
      'blogBody': blog.blogBody,
      'blogImage': blog.blogImage,
      'date': blog.date,
    };
  }
}