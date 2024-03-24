import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Home/components/nav_bar.dart';
import 'package:wildlifeconnect/pages/Profile/pages/profile.dart';
import 'package:wildlifeconnect/pages/Home/home.dart';
import 'package:wildlifeconnect/pages/Library/library.dart';
import 'package:wildlifeconnect/pages/Auth/Login/login.dart';
import 'package:wildlifeconnect/pages/Map/map.dart';
import 'package:wildlifeconnect/pages/Search/search.dart';
import 'package:wildlifeconnect/pages/Auth/Signup/signup.dart';
import 'pages/splashPage/splash_page.dart';

void main() async {
  runApp(const WildlifeConnectApp());
}

class WildlifeConnectApp extends StatelessWidget {
  const WildlifeConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wildlife Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(), 
      routes: {
        '/homepage': (context) => const HomePage(),
        '/librarypage': (context) => const LibraryPage(),
        '/mappage': (context) => const MapPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/search': (context) => const SearchPage(),
        '/loginpage': (context) => const LoginPage(),
        '/signuppage': (context) => const SignUpPage(),
        '/navbar': (context) => const NavBar(),
      },
    );
  }
}
