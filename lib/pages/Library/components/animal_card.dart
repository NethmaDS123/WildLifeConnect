// animal_card.dart
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String animalName;

  const AnimalCard({Key? key, required this.animalName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.green,
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
    );
  }
}
