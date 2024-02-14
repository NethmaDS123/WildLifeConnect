import 'package:flutter/material.dart';

class AnimalImageBox extends StatelessWidget {
  const AnimalImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/animal.jpg'),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
