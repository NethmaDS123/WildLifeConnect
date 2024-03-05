import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Profile/pages/report_crimes.dart';

class PostView extends StatelessWidget {
  final String imgUrl;

  const PostView({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            buildTopBar(context),
            Expanded(
              child: Center(
                child: Container(
                  color: Colors.white,
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            buildBottomBar(),
            const SizedBox(height: 20), // Add space for the "Report Crimes" button
            FloatingActionButton( // Correct navigation to SideBar
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SideBar()));
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.phone_forwarded, color: Colors.white),
            ),
          ],
        ),
      );

  Widget buildTopBar(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          children: [
            ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: const NetworkImage(
                    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              "John Doe",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      );

  Widget buildBottomBar() => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30,
          ),
        ),
      );
}