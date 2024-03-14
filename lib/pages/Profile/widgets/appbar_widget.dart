import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Profile/pages/edit_profile.dart';
import 'package:wildlifeconnect/pages/Profile/pages/search_users.dart';

AppBar buildAppBar(BuildContext context, isEdit) {
  const icon = Icons.settings;
  return AppBar(
    automaticallyImplyLeading: false,
    // leading: isEdit
    //     ? BackButton(
    //         onPressed: () => Get.back(),
    //         color: Colors.white,
    //       )
    //     : null,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () => Get.to(
                () => const EditProfilePage(),
              ),
          icon: const Icon(
            icon,
            color: Colors.white,
          ))
    ],
    leading: IconButton(
      icon: const Icon(Icons.search, color: Colors.white),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchUserPage()),
        );
      },
    ),
  );
}
