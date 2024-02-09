import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/components/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
      // bottomNavigationBar: const NavBar(),
    );
  }
}
