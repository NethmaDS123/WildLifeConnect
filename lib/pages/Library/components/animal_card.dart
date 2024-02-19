import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String animalName;
  final VoidCallback onTap;

  const AnimalCard({super.key, required this.animalName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 10,
        color: const Color.fromARGB(255, 6, 118, 10),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment
                .center, // Align items to the center along the main axis
            children: <Widget>[
              Text(
                animalName,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center, // Center text alignment
              ),
            ],
          ),
        ),
      ),
    );
  }
}
