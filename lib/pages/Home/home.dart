import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';
import 'package:wildlifeconnect/pages/Home/components/camera_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                // Here we implement the logout functionality
                await SecureStorage.deleteToken(); // Delete the JWT token
                Navigator.of(context).pushNamedAndRemoveUntil('/loginpage',
                    (route) => false); // Navigate back to the login page
              }),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  // Example image URLs (replace with your actual image URLs)
                  List<String> imageUrls = [
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                  ];
                  return Card(
                    elevation: 7,
                    margin: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Post Title $index',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Displaying the image for each post
                          Image.network(imageUrls[index]),
                          const SizedBox(height: 20),
                          const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle like button press
                                },
                                icon: const Icon(Icons.thumb_up),
                                label: const Text('Like'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle comment button press
                                },
                                icon: const Icon(Icons.comment),
                                label: const Text('Comment'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Handle share button press
                                },
                                icon: const Icon(Icons.share),
                                label: const Text('Share'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
