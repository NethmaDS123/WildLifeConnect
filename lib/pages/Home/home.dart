import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:wildlifeconnect/pages/Home/components/camera_page.dart';
import 'package:wildlifeconnect/pages/Posts/API/post_model.dart'; // Import the Post class
import 'package:wildlifeconnect/pages/Posts/API/post_service.dart';
import 'package:wildlifeconnect/pages/Posts/post_template.dart'; // Import the function to fetch user posts

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> _userPosts; // Future to hold user posts

  @override
  void initState() {
    super.initState();
    _userPosts = fetchAllPosts(); // Fetch user posts when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await SecureStorage.deleteToken();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/loginpage', (route) => false);
            },
          ),
        ],
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            );
          },
        ),
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.tealAccent, Colors.green],
          ),
        ),
        child: FutureBuilder<List<Post>>(
          future: _userPosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return PostTemplate(post: snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
