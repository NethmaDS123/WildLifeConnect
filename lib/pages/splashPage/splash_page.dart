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
              "assets/animations/splashAnimation1.json",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      //Checks to see if user is logged in or not
      nextScreen: const SignUpPage(),
      splashIconSize: 800,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
