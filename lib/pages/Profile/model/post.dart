class Post {
  final String imgUrl;
  final String userName;

  Post({
    required this.imgUrl,
    required this.userName,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      imgUrl: json['imgUrl'],
      userName: json['userName'],
    );
  }
}
