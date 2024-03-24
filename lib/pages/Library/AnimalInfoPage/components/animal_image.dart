import 'package:flutter/material.dart';

class AnimalImageBox extends StatelessWidget {
  final String? imageUrl;

  const AnimalImageBox({super.key, required this.imageUrl});

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
