import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Profile/update-profile/update_profile.dart';
import 'package:get/get.dart';

class CollectionBtn extends StatelessWidget {
  final double height;
  final double width;
  const CollectionBtn({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: ElevatedButton(
        onPressed: () => Get.to(() => const UpdateProfile()),
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shadowColor: const Color.fromARGB(255, 120, 120, 120),
          backgroundColor: Color.fromARGB(255, 36, 36, 36),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: Size(width / 1.1, height / 14),
        ),
        child: const Text(
          'Edit Profile',
          style: TextStyle(
              color: Color.fromARGB(255, 133, 255, 129),
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
