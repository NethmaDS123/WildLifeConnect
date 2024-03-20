import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 23, 176, 54),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        onPressed: onClicked,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      );
}
