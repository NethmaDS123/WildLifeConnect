import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/components/animal_image.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/components/info_display.dart';

class AnimalInfoPage extends StatelessWidget {
  final String animalName;
  const AnimalInfoPage({super.key, required this.animalName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal Information'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: const [
          AnimalImageBox(),
          AnimalInfoBox(),
        ],
      ),
    );
  }
}
