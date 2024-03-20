import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Profile/pages/post_view.dart';

class PostWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imgUrl;
  final String caption;
  const PostWidget({
    super.key,
    required this.height,
    required this.width,
    required this.imgUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: () => Get.to(() => PostView(
              imgUrl: imgUrl,
              caption: caption,
            )),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
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
