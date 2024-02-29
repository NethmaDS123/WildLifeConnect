import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Profile/pages/post_view.dart';

class Post extends StatelessWidget {
  final double height;
  final double width;
  final String imgUrl;
  const Post({
    Key? key,
    required this.height,
    required this.width,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: () => Get.to(() => PostView(imgUrl: imgUrl)),
        child: Container(
          color: Color.fromARGB(255, 255, 255, 255),
          height: height / 7,
          width: height / 7,
          child: Image(
            image: NetworkImage(
              imgUrl,
            ),
          ),
        ),
      );
}
