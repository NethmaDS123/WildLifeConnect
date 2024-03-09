import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/API/animal_service.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/animal_info_page.dart';
import 'package:wildlifeconnect/pages/Library/components/animal_card.dart';
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';
import 'package:http/http.dart' as http;
import 'components/search_bar.dart' as wb;

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late Future<Map<String, List<Animal>>> groupedAnimalsFuture;

  // Define the order of conservation statuses
  final List<String> statusOrder = [
    'Extinct',
    'Critically Endangered',
    'Endangered',
    'Vulnerable',
    'Near Threatened',
    'Not Threatened',
    'Least Concern',
  ];

  @override
  void initState() {
    super.initState();
    groupedAnimalsFuture = fetchAndGroupAnimals();
  }

  Future<Map<String, List<Animal>>> fetchAndGroupAnimals(
      {String query = ''}) async {
    List<Animal> animals = await fetchAnimals(); // Fetch all animals
    // Filter animals based on the search query
    List<Animal> filteredAnimals = query.isEmpty
        ? animals
        : animals
            .where((animal) =>
                animal.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    Map<String, List<Animal>> grouped = {};
    for (var animal in filteredAnimals) {
      grouped.putIfAbsent(animal.conservationStatus, () => []).add(animal);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Page'),
      ),
      body: Column(
        children: [
          wb.SearchBar(
              onSearch: _handleSearch), // Assuming this is a search bar widget
          Expanded(
            child: FutureBuilder<Map<String, List<Animal>>>(
              future: groupedAnimalsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  // Sort the map entries according to the predefined order
                  List<MapEntry<String, List<Animal>>> sortedEntries =
                      snapshot.data!.entries.toList()
                        ..sort((a, b) => statusOrder
                            .indexOf(a.key)
                            .compareTo(statusOrder.indexOf(b.key)));

                  return ListView.builder(
                    itemCount: sortedEntries.length,
                    itemBuilder: (context, index) {
                      var entry = sortedEntries[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: entry.value.length,
                              itemBuilder: (context, index) {
                                Animal animal = entry.value[index];
                                return Container(
                                  width: 160,
                                  child: AnimalCard(
                                    animalName: animal.name,
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnimalInfoPage(animal: animal),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No animals found"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearch(String query) {
    setState(() {
      groupedAnimalsFuture = fetchAndGroupAnimals(query: query);
    });
  }
}
