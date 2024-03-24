import 'package:flutter/material.dart';

Color _getRarityColor(String rarity) {
  switch (rarity) {
    case 'common':
      return Colors.grey;
    case 'uncommon':
      return Colors.green;
    case 'rare':
      return Colors.blue;
    case 'epic':
      return Colors.purple;
    case 'legendary':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

class TokenWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final String animalName;
  final String rarity;
  const TokenWidget({
    super.key,
    required this.height,
    required this.width,
    required this.imageUrl,
    required this.animalName,
    required this.rarity,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: _getRarityColor(rarity),
          width: 10.0
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit:BoxFit.cover
        ),
      ),
      height: height / 7,
      width: height / 7,
      child: Card(
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
    ),
  );
}
