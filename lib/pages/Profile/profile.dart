import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Profile/components/collection_btn.dart';
import 'package:wildlifeconnect/pages/Profile/components/followers_count.dart';
import 'package:wildlifeconnect/pages/Profile/components/post.dart';
import 'package:wildlifeconnect/pages/Profile/components/profile_img.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ProfileImg(height: height),
                Positioned(
                  bottom: 7,
                  child: FollowersCount(height: height, width: width),
                ),
              ],
            ),
            CollectionBtn(height: height, width: width),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Post(height: height, width: width),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Post(height: height, width: width),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Post(height: height, width: width),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
