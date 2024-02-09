import 'package:flutter/material.dart';

class AnimalInfoPage extends StatelessWidget {
  final String animalName;
  const AnimalInfoPage({super.key, required this.animalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Information'),
      ),
      body: Center(
        child: Text('This is the animal information page'),
      ),
    );
  }
}
