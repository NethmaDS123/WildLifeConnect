import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/API/animal_service.dart';
import 'package:wildlifeconnect/pages/Library/AnimalInfoPage/animal_info_page.dart';
import 'package:wildlifeconnect/pages/Library/components/animal_card.dart';
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';
import 'package:wildlifeconnect/pages/Tokens/tokens.dart';
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
        title: const Text(
          'Library Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 8.0),
                child: Card(
                  elevation: 10,
                  color: Colors
                      .transparent, // Set search bar card color to transparent
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: wb.SearchBar(
                      onSearch: _handleSearch,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 10,
                  color: const Color.fromRGBO(0, 0, 0, 0.65),
                  shadowColor: const Color.fromRGBO(38, 36, 38, 0.498),
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
                                      horizontal: 16.0, vertical: 10.0),
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 175,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: entry.value.length,
                                    itemBuilder: (context, index) {
                                      Animal animal = entry.value[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0),
                                        child: Container(
                                          width: 140,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(1.0),
                                                blurRadius: 1, // Blur radius
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.white.withOpacity(
                                                  1.0),
                                              width: 1.5, 
                                            ),
                                          ),
                                          child: AnimalCard(
                                            animalName: animal.name,
                                            imageUrl: animal.imageUrl,
                                            onTap: () =>
                                                Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AnimalInfoPage(
                                                        animal: animal),
                                              ),
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
              ),
            ],
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
