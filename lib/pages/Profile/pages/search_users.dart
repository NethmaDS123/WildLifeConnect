import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key? key}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchUsers(String username) async {
    try {
      final response = await http.get(Uri.parse(
          'https://wildlifeconnectbackend.onrender.com/users/search/$username'));

      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body);
          // Filter search results to only include the specific username
          _searchResults.retainWhere((result) =>
              result['username'].toLowerCase() == username.toLowerCase());
        });
      } else {
        throw Exception(
            'Failed to load search results: ${response.statusCode}');
      }
    } catch (error) {
      print('Error searching users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'User Search',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for users...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(1.0)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.white),
                      onPressed: () {
                        _searchController.clear();
                        _searchUsers(' ');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 3.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent.withOpacity(0.5),
                  ),
                  onChanged: (value) {
                    String username = _searchController.text.trim();
                    _searchUsers(username);
                  },
                ),
              ),
              Expanded(
                child: _searchResults.isEmpty
                    ? const Center(
                        child: Text('No results found',
                            style: TextStyle(color: Colors.white)))
                    : ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              print('User profile tapped');
                              // Navigate to user profile page here
                            },
                            child: ListTile(
                              title: Text(_searchResults[index]['username'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                _searchResults[index]['firstName'] +
                                    ' ' +
                                    _searchResults[index]['lastName'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  print('Add friend button pressed');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: const Text(
                                  'Add Friend',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
