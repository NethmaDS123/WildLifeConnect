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
  const CreatePost({super.key});

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

//picking image to post

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final TextEditingController _captionController = TextEditingController();
  final storage = const FlutterSecureStorage();

  Future<void> _pickImage() async {
    final XFile? selected =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selected;
    });
  }

  Future<void> _uploadPost() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

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

    // Determine the mime type of the selected file
    var mimeTypeData =
        lookupMimeType(_image!.path, headerBytes: [0xFF, 0xD8])?.split('/');
    // Ensure mimeTypeData is not null before proceeding
    if (mimeTypeData != null) {
      var file = await http.MultipartFile.fromPath(
        'image',
        _image!.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );
      request.files.add(file);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Post uploaded successfully");
        // Optionally reset state to allow for another post
        setState(() {
          _image = null;
          _captionController.clear();
          _location = null;
        });
      } else {
        print("Posting failed");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not determine file type')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Create Post',
          style: TextStyle(
            color: Colors.white,
          ),
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
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            _image != null
                ? Image.file(File(_image!.path))
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
