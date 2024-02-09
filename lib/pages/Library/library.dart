// library_page.dart
import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Library/animal_info_page.dart';
import 'package:wildlifeconnect/pages/Library/components/animal_card.dart';
import 'components/search_bar.dart' as wb; // Alias for the search bar import

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  void _handleSearch(String query) {
    // Implement search functionality
    print('Searching for: $query');
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder for your animals data
    final List<String> animals = [
      'Lion',
      'Tiger',
      'Bear',
      'Elephant',
      'Buffolo',
      'Deer',
      'Crocodile'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Library Page'),
      ),
      body: Column(
        children: [
          wb.SearchBar(onSearch: _handleSearch),
          Expanded(
            child: ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                return AnimalCard(
                  animalName: animals[index],
                  // Navigate to the animal info page when the card is tapped
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AnimalInfoPage(animalName: animals[index]),
                    ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
