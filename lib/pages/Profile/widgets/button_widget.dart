import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({Key? key, required this.text, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 23, 176, 54),
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        onPressed: onClicked,
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
      );
}
