import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Profile/pages/report_crimes.dart'; // Ensure correct path

class PostView extends StatelessWidget {
  final String imgUrl;

  const PostView({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.report_problem, color: Colors.white),
            // Correct navigation to ReportCrimes page
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 400,
              width: double.infinity,
              color: Colors.white,
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            // Other content as needed
          ],
        ),
      ),
      // Floating action button or other widgets as needed
    );
  }
}
