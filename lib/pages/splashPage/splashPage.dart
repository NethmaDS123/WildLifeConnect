import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/home.dart';
// import '../Login/login.dart'; // Import the login page.

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a delay to view the splash screen, then navigate to the login page.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Wildlife Connect',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
