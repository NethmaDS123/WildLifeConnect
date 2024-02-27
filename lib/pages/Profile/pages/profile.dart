import 'package:flutter/material.dart';
import 'package:wildlifeconnect/model/user_test.dart';
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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    const prof_user = UserPreferences.myUser;
    const imgUrl =
        'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildAppBar(context, false),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Your existing profile widget and spacers
          ProfileWidget(
            isEdit: false,
            imagePath: prof_user.imagePath,
          ),
          const SizedBox(height: 24),
          buildName(prof_user),
          const SizedBox(height: 24),
          Center(child: buildFollowButton()),
          NumbersWidget(),

          const SizedBox(height: 24),
          GridView.count(
            padding: const EdgeInsets.all(5),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
              Post(height: height, width: width, imgUrl: imgUrl),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildName(UserTest user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          Text(
            user.email,
            style: TextStyle(color: const Color.fromARGB(255, 154, 154, 154)),
          ),
        ],
      );

  Widget buildFollowButton() => ButtonWidget(
        onClicked: () {},
        text: 'Follow',
      );
}
