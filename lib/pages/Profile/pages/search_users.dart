import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchUsers(String username) async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/users/search/$username'));

      if (response.statusCode == 200) {
        setState(() {
          _searchResults = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load search results: ${response.statusCode}');
      }
    } catch (error) {
      print('Error searching users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Search'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search for users...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  String username = _searchController.text.trim();
                  _searchUsers(username);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_searchResults[index]['username']),
                  subtitle: Text(_searchResults[index]['email']),
                  // Add more user information as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}