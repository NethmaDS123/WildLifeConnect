import 'package:flutter/material.dart';
import 'pages/splashPage/splashPage.dart'; // Import the splash page.

void main() => runApp(WildlifeConnectApp());

class WildlifeConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildlife Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(), // Set the SplashPage as the home.
      routes: {
        '/splash': (context) => SplashPage(),
        // Define other routes here.
      },
    );
  }
}
