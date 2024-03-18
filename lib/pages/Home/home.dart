import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () async {
                // Here we implement the logout functionality
                await SecureStorage.deleteToken(); // Delete the JWT token
                Navigator.of(context).pushNamedAndRemoveUntil('/loginpage',
                    (route) => false); // Navigate back to the login page
              }),
        ],
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
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
        title: const Text(
          'Wildlife Connect',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'Raleway',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            colorFilter: ColorFilter.mode(
              Color.fromARGB(106, 0, 0, 0),
              BlendMode.darken,
            ),
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
                    'https://images.unsplash.com/photo-1456926631375-92c8ce872def?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHdpbGRsaWZlfGVufDB8fDB8fHww',
                    'https://images.unsplash.com/photo-1589656966895-2f33e7653819?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    'https://images.unsplash.com/photo-1496196614460-48988a57fccf?q=80&w=1548&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://images.unsplash.com/photo-1452570053594-1b985d6ea890?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fHdpbGRsaWZlfGVufDB8fDB8fHww',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                    'https://i.natgeofe.com/n/b64060fa-343c-481b-a24d-7375fef34914/NationalGeographic_1425689_3x4.jpg',
                  ];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            color: Color.fromARGB(255, 32, 117, 45),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Post Title $index',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            ],
                          ),
                        ),
                        //const SizedBox(height: 15),
                        // Displaying the image for each post
                        Image.network(
                          imageUrls[index],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 15),
                                  Icon(
                                    Icons.save_alt,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     ElevatedButton.icon(
                        //       onPressed: () {
                        //         // Handle like button press
                        //       },
                        //       icon: const Icon(Icons.thumb_up),
                        //       label: const Text('Like'),
                        //     ),
                        //     ElevatedButton.icon(
                        //       onPressed: () {
                        //         // Handle comment button press
                        //       },
                        //       icon: const Icon(Icons.comment),
                        //       label: const Text('Comment'),
                        //     ),
                        //     ElevatedButton.icon(
                        //       onPressed: () {
                        //         // Handle share button press
                        //       },
                        //       icon: const Icon(Icons.share),
                        //       label: const Text('Share'),
                        //     ),
                        //   ],
                        // ),
                      ],
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
