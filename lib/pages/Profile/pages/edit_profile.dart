import 'package:flutter/material.dart';
import 'package:wildlifeconnect/model/user_test.dart';
import 'package:wildlifeconnect/pages/Profile/utils/user_preferences.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/appbar_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/profile_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/textfield_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserTest user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
                //to change the cursor and icon color
                cursorColor: Color.fromARGB(255, 255, 255, 255),
                selectionColor: Colors.blue,
                selectionHandleColor: Colors.blue)),
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: buildAppBar(context, true),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Full Name',
                text: user.name,
                onChanged: (name) {},
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Email',
                text: user.email,
                onChanged: (email) {},
              ),
            ],
          ),
        ),
      );
}
