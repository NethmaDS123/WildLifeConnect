import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/model/user_test.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 32),
            physics: const BouncingScrollPhysics(),
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _deleteAccount(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      );

  void _deleteAccount(BuildContext context) async {
    final confirmation = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
                'Are you sure you want to delete your account? This cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmation) return;

    final String? email = await SecureStorage.getEmail();
    if (email == null) {
      print('Email is null, cannot proceed with deletion.');
      return;
    }

    final String? token = await SecureStorage.getToken();
    if (token == null) {
      print('Authentication token is missing.');
      return;
    }

    final response = await http.delete(
      Uri.parse(
          'https://wildlifeconnectbackend.onrender.com/users/deleteByEmail'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      await SecureStorage.clear();
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/loginpage', (Route<dynamic> route) => false);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(
              'Failed to delete account. Please try again. Response: ${response.body}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
