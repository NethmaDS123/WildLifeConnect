class Post {
  final String title;
  final String imageUrl;
  final String caption;

  Post({required this.title, required this.imageUrl, required this.caption});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
    );
  }
}
