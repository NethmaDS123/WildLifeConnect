import 'package:wildlifeconnect/pages/Auth/Login/login.dart';
import 'package:wildlifeconnect/pages/Home/components/nav_bar.dart';
import 'package:wildlifeconnect/pages/Auth/Signup/signup.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              "assets/animations/splashAnimation.json",
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Wildlife Connect",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      nextScreen: NavBar(),
      splashIconSize: 400,
      backgroundColor: const Color.fromARGB(255, 107, 248, 173),
    );
  }
}
