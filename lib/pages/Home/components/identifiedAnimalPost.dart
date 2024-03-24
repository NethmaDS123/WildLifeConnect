// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreatePost extends StatefulWidget {
  final File imageFile;

  const CreatePost({
    Key? key,
    required this.imageFile,
  }) : super(key: key);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String? _location; // To store the location

// Function to get current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // if permissions are denied forever
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permissions are granted, get the position
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _location = "${position.latitude}, ${position.longitude}";
    });
  }

  File? imageFile;

  @override
  void initState() {
    super.initState();
    imageFile = widget.imageFile;
  }
  final TextEditingController _captionController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<void> _uploadPost() async {
    var uri = Uri.parse(
        'https://wildlifeconnectbackend.onrender.com/api/posts/create');
    var request = http.MultipartRequest('POST', uri);

    String? token = await storage.read(key: 'jwt_token');
    request.headers.addAll({'Authorization': 'Bearer $token'});

    // Add caption to request
    request.fields['caption'] = _captionController.text;

    // Include location if available
    if (_location != null) {
      request.fields['location'] = _location!;
    }
  
    var file = await http.MultipartFile.fromPath(
      'image',
      imageFile!.path,
      contentType: MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      print("Post uploaded successfully");
    } else {
      print("Posting failed");
    }
  
  }

  @override
  Widget build(BuildContext context) {
    File imageFile = widget.imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _uploadPost,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _captionController,
                decoration: InputDecoration(
                  labelText: 'Caption',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Location (optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                onChanged: (value) {
                  _location = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Use Current Location'),
            ),
            imageFile != null
                ? Image.file(imageFile)
                : const Text('No image selected'),
            // Optionally, display the current location if available
            if (_location != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Location: $_location"),
              ),
          ],
        ),
      ),
    );
  }
}
