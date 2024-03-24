import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/components/animal_image.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/components/info_display.dart';

class AnimalInfoPage extends StatelessWidget {
  final Animal animal;
  const AnimalInfoPage({super.key, required this.animal});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 126, 220, 129),
      appBar: AppBar(
        title: Text(animal.name),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                    .pushNamedAndRemoveUntil('/navbar', (route) => false);
            },
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            height: screenSize.height * 0.3, // 30% of the screen height
            width: screenSize.width, // Full screen width
            child: AnimalImageBox(imageUrl: animal.imageUrl),
          ),
          Positioned(
            top: screenSize.height * 0.28,
            height: screenSize.height * 0.72, // Remaining height
            width: screenSize.width,
            child: AnimalInfoBox(animal: animal),
          ),
        ],
      ),
    );
  }
}
