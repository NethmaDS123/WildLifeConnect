import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Profile/widgets/token_widget.dart';

class ViewCollectionPage extends StatefulWidget {
  const ViewCollectionPage({Key? key}) : super(key: key);

  @override
  _ViewCollectionPageState createState() => _ViewCollectionPageState();
}

class _ViewCollectionPageState extends State<ViewCollectionPage> {
  late Future<List<dynamic>> userTokens;
  String? userName;
  int tokenCount = 0;

  @override
  void initState() {
    super.initState();
    loadUserData();
    userTokens = fetchTokens();
    loadUserTokens();
  }

  loadUserData() async {
    userName = await SecureStorage.getUsername();
    setState(() {});
  }

  Future<List<dynamic>> fetchTokens() async {
    String? token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    String? username = await SecureStorage.getUsername();

    final response = await http.get(
      Uri.parse(
          'https://wildlifeconnectbackend.onrender.com/tokens/get/$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return Future.value([]);
    }
  }

  void loadUserTokens() async {
    final tokens = await userTokens;
    setState(() {
      tokenCount = tokens.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'View Collection',
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
          // List of Tokens
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                FutureBuilder<List<dynamic>>(
                  future: userTokens,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tokens =
                          snapshot.data!; // Safe access after checking hasData
                      return GridView.count(
                        padding: const EdgeInsets.all(5),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          tokens.length,
                          (index) => TokenWidget(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: tokens[index]['imageUrl'],
                            animalName: tokens[index]
                                ['animalName'], // Access caption from each Post
                            rarity: tokens[index]
                                ['rarity'], // Access username from each Post
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ));
                    } else {
                      return const Center(
                          child: Text(
                        'User has not generated tokens yet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ));
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
