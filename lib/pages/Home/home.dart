import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/navBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WildLifeConnect'),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
