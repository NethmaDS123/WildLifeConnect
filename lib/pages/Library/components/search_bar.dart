import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.white, // white colour border of the search bar
          width: 0.8, // Border width
        ),
      ),
      child: Card(
        elevation: 10, 
        child: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.lime), // Text color of the input field text
          decoration: InputDecoration(
            hintText: 'Search for animals...',
            hintStyle: const TextStyle(color: Colors.white), // Placeholder color
            prefixIcon: const Icon(Icons.search, color: Colors.white), // search icon color
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white), // reset icon color
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 33, 33, 33), // Background color
            border: InputBorder.none, // No border for the input field
          ),
          onChanged: widget.onSearch,
        ),
      ),
    );
  }
}
