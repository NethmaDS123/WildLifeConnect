import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:wildlifeconnect/pages/Posts/API/post_model.dart';


String getBackendUrl() {
  if (Platform.isAndroid) {
    // Use 10.0.2.2 for Android emulator
    return 'http://10.0.2.2:3000';
  } else if (Platform.isIOS) {
    // Use localhost for iOS simulator
    return 'http://localhost:3000';
  } else {
    // Fallback for other platforms
    return 'http://your-production-url.com';
  }
}


   Future<List<Post>> fetchAllPosts() async {
  var backendUrl = getBackendUrl();
  final response = await http.get(Uri.parse('$backendUrl/api/getPosts/getAllPosts'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<dynamic> postsData = jsonData['posts'];
    return postsData.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Failed to fetch posts');
  }
}
