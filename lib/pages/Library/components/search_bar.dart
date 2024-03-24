import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

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
          color: Colors.white, 
          width: 1.5, // Border width
        ),
        color: Colors.transparent,
      ),
      child: TextField(
        controller: _controller,
        style: const TextStyle(color: Colors.white), // input field text color
        decoration: InputDecoration(
          hintText: 'Search for animals...',
          hintStyle: const TextStyle(color: Colors.white), // placeholder color
          prefixIcon: const Icon(Icons.search, color: Colors.white), // search icon color
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white), // reset icon color
            onPressed: () {
              _controller.clear();
              widget.onSearch('');
            },
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none, 
        ),
        onChanged: widget.onSearch,
      ),
    );
  }
}
