import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Profile/pages/edit_profile.dart';

AppBar buildAppBar(BuildContext context, isEdit) {
  const icon = Icons.settings;
  return AppBar(
    leading: isEdit
        ? BackButton(
            onPressed: () => Get.back(),
            color: Colors.white,
          )
        : null,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () => Get.to(() => 
                const EditProfilePage(),
              ),
          icon: const Icon(
            icon,
            color: Colors.white,
          ))
    ],
  );
}
