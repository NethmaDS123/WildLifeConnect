// animal_card.dart
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String animalName;
  final VoidCallback onTap;

  const AnimalCard({Key? key, required this.animalName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        color: const Color.fromARGB(255, 6, 118, 10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                animalName,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 150),
              // Add more information and styling as needed
            ],
          ),
        ),
      ),
    );
  }
}
