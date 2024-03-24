import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';
import 'package:wildlifeconnect/pages/Library/API/animal_service.dart';
import 'package:wildlifeconnect/pages/Home/components/identifiedAnimalInfo.dart';
import 'package:wildlifeconnect/pages/Home/components/identifiedAnimalPost.dart';
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

  Future<List<dynamic>> fetchAnimal() async {
    List<Animal> animals = await fetchAnimals();
    List<dynamic> animal = animals
        .where((element) => element.name.toLowerCase() == prediction.toLowerCase())
        .toList();
    return animal;
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                    .pushNamedAndRemoveUntil('/navbar', (route) => false);
            },
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ],
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
            onPressed: () => {
              fetchAnimal().then((value) {
                Get.to(() => AnimalInfoPage(animal: value[0]));
              })
            },
            child: Text(
              'View Information',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
              minimumSize: const Size(200, 50),
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
            },
            child: Text(
              'Generate Token',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
              minimumSize: const Size(200, 50),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => {
              Get.to(() => CreatePost(
                imageFile: _imageFile
              ))
            },
            child: Text(
              'Post Sighting',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
              minimumSize: const Size(200, 50),
            ),
          ),
        ],
      ),
    );
  }
}
