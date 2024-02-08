import 'package:flutter/material.dart';

class FollowersCount extends StatelessWidget {
  final double height;
  final double width;
  const FollowersCount({Key? key, required this.height, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 10,
      width: width / 1.1,
      decoration: BoxDecoration(
        color: Color.fromARGB(236, 18, 18, 18),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            followersText('12', 'posts'),
            const SizedBox(
              height: 50,
              width: 1.0,
              child: VerticalDivider(
                color: Color.fromARGB(255, 105, 105, 105),
              ),
            ),
            followersText('200', 'followers'),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Color.fromARGB(255, 105, 105, 105),
              ),
            ),
            followersText('50', 'following'),
          ],
        ),
      ),
    );
  }

  Widget followersText(String count, String tag) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            count,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 133, 255, 129),
            ),
          ),
          Text(
            tag,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color.fromARGB(255, 133, 255, 129),
            ),
          )
        ],
      );
}
