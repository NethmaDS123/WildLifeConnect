import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:http/http.dart' as http;

class PostView extends StatelessWidget {
  final String imgUrl;
  final String caption;
  final String username;

  const PostView({
    super.key,
    required this.imgUrl,
    required this.caption,
    required this.username,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: buildTopBar()),
              Center(
                child: Container(
                  height: 400,
                  width: 400,
                  color: Colors.white,
                  child: Image(
                    image: NetworkImage(
                      imgUrl,
                    ),
                  ),
                ),
              ),
              buildBottomBar(context),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  caption,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildTopBar() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: Ink.image(
                      image: const NetworkImage(
                        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ),
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  username,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ],
        ),
      );

  Widget buildBottomBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 10, 5),
            child: GestureDetector(
              onTap: () => {deletePost(context)},
              child: const Icon(
                CupertinoIcons.delete,
                color: Color.fromARGB(255, 255, 0, 0),
                size: 25,
              ),
            ),
          ),
        ],
      );

  void deletePost(BuildContext context) async {
    final confirmation = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text('Are you sure you want to delete this post?.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmation) return;

    final String? token = await SecureStorage.getToken();
    if (token == null) {
      return;
    }

    // Construct the body
    final bodyData = {"imgUrl": imgUrl, "username": username};

    final response = await http.delete(
      Uri.parse('https://wildlifeconnectbackend.onrender.com/api/posts/delete'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(bodyData),
    );

    if (response.statusCode == 200) {
      Get.back();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to delete post. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
