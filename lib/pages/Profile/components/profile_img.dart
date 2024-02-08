import 'package:flutter/material.dart';

class ProfileImg extends StatelessWidget {
  final double height;
  const ProfileImg({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 3,
      child: const Image(
        image: NetworkImage(
            'https://cdn.pixabay.com/photo/2018/05/03/06/19/jaguar-3370498_640.jpg'),
      ),
    );
  }
}
