import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      // ignore: avoid_print
      print('Error searching users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for users...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchUsers(' ');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onChanged: (value) {
                String username = _searchController.text.trim();
                _searchUsers(username);
              },
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text('No results found'))
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // ignore: avoid_print
                          print('User profile tapped');
                          // Navigate to user profile page here
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => UserProfilePage(
                          //       userData: _searchResults[index], // Pass user data to the profile page
                          //     ),
                          //   ),
                          // );
                        },
                        child: ListTile(
                          title: Text(_searchResults[index]['username']),
                          subtitle: Text(_searchResults[index]['firstName'] +
                              ' ' +
                              _searchResults[index]['lastName']),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // ignore: avoid_print
                              print('Add friend button pressed');
                              // Add friend logic here
                            },
                            child: const Text('Add Friend'),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
