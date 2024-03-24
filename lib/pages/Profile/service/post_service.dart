import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Profile/model/post.dart';

// String getBackendUrl() {
//   if (Platform.isAndroid) {
//     return 'http://10.0.2.2:3000';
//   } else if (Platform.isIOS) {
//     return 'http://localhost:3000';
//   } else {
//     return 'http://your-production-url.com';
//   }
// }

Future<List<Post>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://wildlifeconnectbackend.onrender.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
    return posts;
  } else {
    throw Exception('Failed to load posts');
  }
}
