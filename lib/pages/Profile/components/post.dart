import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final double height;
  final double width;
  const Post({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      height: height / 7,
      width: height / 7,
      child: const Image(
        image: NetworkImage(
          'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
        ),
      ),
    );
  }
}
