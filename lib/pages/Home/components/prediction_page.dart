import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Tokens/tokens.dart';

class PredictionPage extends StatelessWidget {
  final String imgUrl;
  final String prediction;
  final File imageFile;

  const PredictionPage({
    Key? key,
    required this.imgUrl,
    required this.prediction,
    required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File _imageFile = imageFile;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              prediction,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: 600,
            child: Image(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => {}, // Add Button1 logic
            child: Text(
              'Button1',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => {
              Get.to(() => TokenGenerator(
                animalName: prediction,
                imageFile: _imageFile
              ))
            }, // Add Button2 logic
            child: Text(
              'Generate Token',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => {}, // Add Button3 logic
            child: Text(
              'Button3',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
        ],
      ),
    );
  }
}
