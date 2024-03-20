import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart'; // Ensure this import points to your Animal model's correct location

class AnimalInfoBox extends StatelessWidget {
  final Animal animal;

  const AnimalInfoBox({
    super.key,
    required this.animal,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Use SingleChildScrollView to allow for scrolling if content exceeds screen size
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 126, 220, 129),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${animal.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Conservation Status: ${animal.conservationStatus}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Locations: ${animal.locations.join(', ')}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Kingdom: ${animal.taxonomy['kingdom'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Scientific Name: ${animal.taxonomy['scientific_name']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Lifespan: ${animal.characteristics['lifespan'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Habitat: ${animal.characteristics['habitat'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Diet: ${animal.characteristics['diet'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "Average litter size: ${animal.characteristics['average_litter_size'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Predators: ${animal.characteristics['predators'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Prey: ${animal.characteristics['prey'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),

              Text("Top speed: ${animal.characteristics['top_speed'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              Text("Skin type: ${animal.characteristics['skin_type'] ?? 'N/A'}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              // Add any other relevant fields here
            ],
          ),
        ),
      ),
    );
  }
}
