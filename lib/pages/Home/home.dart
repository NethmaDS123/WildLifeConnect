import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:wildlifeconnect/pages/Home/components/camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> posts;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    posts = fetchPosts();
    _startPolling();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void _startPolling() {
    const Duration pollInterval = Duration(seconds: 30);

    _timer = Timer.periodic(pollInterval, (timer) {
      // Fetch posts periodically
      setState(() {
        posts = fetchPosts();
      });
    });
  }

  Future<List<dynamic>> fetchPosts() async {
    String? token = await SecureStorage.getToken();

    final response = await http.get(
      Uri.parse('https://wildlifeconnectbackend.onrender.com/api/posts/get'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20.0), 
            child: IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white, 
              ),
              onPressed: () async {
                await SecureStorage.deleteToken();
                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/loginpage', (route) => false);
              },
            ),
          ),
        ],
        backgroundColor: Colors.black, 
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 20.0), 
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white, 
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraPage()),
              );
            },
          ),
        ),
        title: const Text(
          'Wildlife Connect',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(
                255, 255, 255, 255),
            fontFamily: 'Raleway',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        // Use Stack to place the content above the camera and logout icons
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                    'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          FutureBuilder<List<dynamic>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color.fromARGB(255, 0, 53, 10).withOpacity(
                            0.9), 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              color: Color.fromARGB(255, 0, 48,
                                  7), 
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post['name'] ?? 'NO caption',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                const Icon(
                                  Icons.more_vert,
                                  color: Colors
                                      .white, 
                                )
                              ],
                            ),
                          ),
                          Image.network(
                            post['imageUrl'], 
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0), 
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(width: 15),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top:
                                                8.0), 
                                        child: Icon(
                                          Icons.save_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  post['caption'] ?? 'NO caption',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
