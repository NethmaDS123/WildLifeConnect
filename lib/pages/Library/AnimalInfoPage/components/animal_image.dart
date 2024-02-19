import 'package:flutter/material.dart';

class AnimalImageBox extends StatelessWidget {
  final String? imageUrl; // Make sure this is correctly typed as a parameter

  const AnimalImageBox({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: const Color.fromARGB(255, 255, 255, 255),
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }
}
