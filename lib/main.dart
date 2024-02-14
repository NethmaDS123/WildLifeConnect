import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/home.dart';
import 'package:wildlifeconnect/pages/Library/library.dart';
import 'package:wildlifeconnect/pages/Auth/Login/login.dart';
import 'package:wildlifeconnect/pages/Map/map.dart';
import 'package:wildlifeconnect/pages/Profile/profile.dart';
import 'package:wildlifeconnect/pages/Search/search.dart';
import 'package:wildlifeconnect/pages/Auth/Signup/signup.dart';
import 'pages/SplashPage/splash_page.dart';

void main() => runApp(const WildlifeConnectApp());

class WildlifeConnectApp extends StatelessWidget {
  const WildlifeConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wildlife Connect',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(), // Initially show the SplashPage
      routes: {
        '/homepage': (context) => const HomePage(),
        '/librarypage': (context) => const LibraryPage(),
        '/mappage': (context) => const MapPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/search': (context) => const SearchPage(),
        '/loginpage': (context) => const LoginPage(),
        '/signuppage': (context) => const SignUpPage()
      },
    );
  }
}
