import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: height / 3,
                    child: const Image(
                      color: Color.fromARGB(129, 0, 0, 0),
                      colorBlendMode: BlendMode.darken,
                      image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/05/03/06/19/jaguar-3370498_640.jpg',
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 90,
                    child: Text(
                      'John Doe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Positioned(
                    bottom: 7,
                    child: followersBar(height, width),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    shadowColor: const Color.fromARGB(255, 120, 120, 120),
                    backgroundColor: Color.fromARGB(255, 36, 36, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(width / 1.1, height / 14),
                  ),
                  child: const Text(
                    'My Collection',
                    style: TextStyle(
                        color: Color.fromARGB(255, 133, 255, 129),
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget followersBar(double height, double width) => Container(
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
