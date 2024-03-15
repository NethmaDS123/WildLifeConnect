import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:wildlifeconnect/pages/Profile/model/post.dart';
import 'package:wildlifeconnect/pages/Profile/pages/sidebar_widget.dart';
import 'package:wildlifeconnect/pages/Profile/service/post_service.dart';
import 'package:wildlifeconnect/pages/Profile/utils/user_preferences.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/appbar_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/button_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/numbers_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/post_widget.dart';
import 'package:wildlifeconnect/pages/Profile/widgets/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage> {
  late Future<List<Post>> postsFuture;
  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    super.initState();
    postsFuture = fetchAllPosts();
    loadUserData();
  }

  Future<List<Post>> fetchAllPosts() {
    return fetchPosts();
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
          child: SidebarWidget(),
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
          NumbersWidget(),
          const SizedBox(height: 12.0),
          Center(
            child: buildReportButton(),
          ),
          const SizedBox(height: 14),
          FutureBuilder<List<Post>>(
            future: postsFuture,
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
                      imgUrl:
                          posts[index].imgUrl, // Access imgUrl from each Post
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ));
              }

              // Show a loading indicator while waiting for data
              return const Center(child: CircularProgressIndicator());
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

  Widget buildReportButton() => Container(
        height: 38.0,
        width: 185.0,
        child: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => {
              Scaffold.of(context).openEndDrawer(),
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 176, 54),
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
