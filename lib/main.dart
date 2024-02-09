import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/home.dart';
import 'package:wildlifeconnect/pages/Library/library.dart';
import 'package:wildlifeconnect/pages/Login/login.dart';
import 'package:wildlifeconnect/pages/Map/map.dart';
import 'package:wildlifeconnect/pages/Profile/profile.dart';
import 'package:wildlifeconnect/pages/Search/search.dart';
import 'package:wildlifeconnect/pages/Signup/signup.dart';
import 'pages/splashPage/splash_page.dart';

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
      home: const SplashScreen(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/librarypage': (context) => LibraryPage(),
        '/mappage': (context) => MapPage(),
        '/profilepage': (context) => ProfilePage(),
        '/search': (context) => SearchPage(),
        '/loginpage': (context) => LoginPage(),
        '/signuppage': (context) => SignUpPage()
      }, // Initially show the SplashPage
    );
  }
}
