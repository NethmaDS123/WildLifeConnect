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
          ProfileWidget(
            isEdit: false,
            imagePath: prof_user.imagePath,
          ),
          const SizedBox(height: 18),
          buildName(prof_user),
          const SizedBox(height: 8),
          Center(
            child: buildFollowButton(),
          ),
          const SizedBox(height: 8),
          NumbersWidget(),
          Center(child: buildReportButton()),
          const SizedBox(height: 14),
          GridView.count(
            padding: const EdgeInsets.all(5),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
              PostWidget(height: height, width: width, imgUrl: imgUrl),
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
          // Text(
          //   user.email,
          //   style: TextStyle(color: const Color.fromARGB(255, 154, 154, 154)),
          // ),
        ],
      );

  Widget buildFollowButton() => ButtonWidget(
        onClicked: () {},
        text: 'Follow',
      );

  Widget buildReportButton() => GestureDetector(
        onTap: () => {print('tapped')},
        child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                // Wrap Icon with Flexible
                child: Icon(Icons.phone_forwarded),
              ),
              SizedBox(width: 15),
              Flexible(
                // Wrap Text with Flexible
                child: Text('Report Crimes'),
              ),
            ],
          ),
        ),
      );
}
