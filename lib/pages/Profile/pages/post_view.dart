import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Center(child: buildBottomBar()),
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

  Widget buildBottomBar() => Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
        child: GestureDetector(
          onTap: () => {},
          child: const Icon(
            CupertinoIcons.heart_fill,
            color: Color.fromARGB(255, 255, 0, 0),
            size: 30,
          ),
        ),
      );
}
