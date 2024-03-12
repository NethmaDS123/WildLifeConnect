import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String animalName;
  final String? imageUrl;
  final VoidCallback onTap;

  const AnimalCard({super.key, required this.animalName, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit:BoxFit.cover
                  ),
                ),child: Card(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Align items to the center along the main axis
                      children: <Widget>[
                        Text(
                          animalName,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center, // Center text alignment
                        ),
                      ],
                    ),
                  ),
                ),
        )
      ),
    );
  }
}
