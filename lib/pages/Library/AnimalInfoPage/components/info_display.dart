import 'package:flutter/material.dart';

class AnimalInfoBox extends StatelessWidget {
  const AnimalInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
