// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:wildlifeconnect/pages/Profile/pages/sidebar_widget.dart';
import 'package:wildlifeconnect/pages/Profile/utils/user_preferences.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/appbar_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/button_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/numbers_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/post_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/profile_widget.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage> {
  late Future<List<dynamic>> userPosts;
  String? firstName;
  String? lastName;
  String? email;
  String? userName;

  @override
  void initState() {
    super.initState();
    loadUserData();
    userPosts = fetchPosts();
  }

  Future<List<dynamic>> fetchPosts() async {
    String? token = await SecureStorage.getToken();

    String? username = await SecureStorage.getUsername();

    final response = await http.get(
      Uri.parse(
          'https://wildlifeconnectbackend.onrender.com/api/posts/get/$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return Future.value([]);
    }
  }

  loadUserData() async {
    firstName = await SecureStorage.getFirstName();
    lastName = await SecureStorage.getLastName();
    email = await SecureStorage.getEmail();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const profUser = UserPreferences.myUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context, false),
      endDrawer: Drawer(
        child: Container(
          child: const SidebarWidget(),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            isEdit: false,
            imagePath: profUser.imagePath,
          ),
          const SizedBox(height: 18),
          buildName(),
          //const SizedBox(height: 8),
          // Center(
          //   child: buildFollowButton(),
          // ),
          const SizedBox(height: 2),
          const NumbersWidget(),
          const SizedBox(height: 12.0),
          Center(
            child: buildReportButton(),
          ),
          const SizedBox(height: 14),
          FutureBuilder<List<dynamic>>(
            future: userPosts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final posts =
                    snapshot.data!; // Safe access after checking hasData
                return GridView.count(
                  padding: const EdgeInsets.all(5),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    posts.length,
                    (index) => PostWidget(
                      height: height,
                      width: width,
                      imgUrl: posts[index]['imageUrl'],
                      caption: posts[index]
                          ['caption'], // Access caption from each Post
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ));
              } else {
                return const Center(
                    child: Text(
                  'User has not posted yet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            '$firstName $lastName',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              letterSpacing: 1.5,
            ),
          ),
          Text(
            '$email',
            style: const TextStyle(
              color: Color.fromARGB(255, 174, 174, 174),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      );

  Widget buildFollowButton() => ButtonWidget(
        onClicked: () {},
        text: 'Follow',
      );

  Widget buildReportButton() => SizedBox(
        height: 38.0,
        width: 185.0,
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => {
              Scaffold.of(context).openEndDrawer(),
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 176, 54),
                borderRadius: BorderRadius.circular(6.0),

                // border: Border.all(
                //   width: 2,
                //   color: Color.fromARGB(255, 23, 176, 54),
                // ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_forwarded,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Report Crimes',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          );
        }),
      );
}
