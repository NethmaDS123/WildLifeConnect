import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostView extends StatelessWidget {
  final String imgUrl;

  const PostView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

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
            children: [
              buildTopBar(),
              Container(
                height: 400,
                width: 400,
                color: Colors.white,
                child: Image(
                  image: NetworkImage(
                    imgUrl,
                  ),
                ),
              ),
              buildBottomBar(),
            ],
          ),
        ),
      );

  Widget buildTopBar() => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                const Text(
                  "John Doe",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ],
        ),
      );

  Widget buildBottomBar() => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
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
