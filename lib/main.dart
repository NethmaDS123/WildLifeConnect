import 'package:flutter/material.dart';
import 'pages/splashPage/splash_page.dart'; // Import the splash page.

void main() => runApp(const WildlifeConnectApp());

class WildlifeConnectApp extends StatelessWidget {
  const WildlifeConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildlife Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(), // Initially show the SplashPage
    );
  }
}
