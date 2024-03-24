import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String? _location; 

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

    if (_location != null) {
      request.fields['location'] = _location!;
    }

    var mimeTypeData =
        lookupMimeType(_image!.path, headerBytes: [0xFF, 0xD8])?.split('/');
    
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
        // reset state to allow for another post
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
          SingleChildScrollView(
            // Use SingleChildScrollView to prevent overflow
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextFormField(
                        controller: _captionController,
                        decoration: InputDecoration(
                          labelText: 'Caption',
                          labelStyle: const TextStyle(
                              color: Colors.white), // Label color
                          hintText: 'Enter caption',
                          hintStyle: const TextStyle(
                              color: Colors.white), // Placeholder color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color
                              width: 1.5, // Border width
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color
                              width: 1.5, // Border width
                            ),
                          ),
                        ),
                        style:
                            const TextStyle(color: Colors.white), // Text color
                        maxLines: null,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Location (optional)",
                          labelStyle: const TextStyle(
                              color: Colors.white), // Label color
                          hintText: 'Enter location',
                          hintStyle: const TextStyle(
                              color: Colors.white), // Placeholder color
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color
                              width: 1.5, // Border width
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: const BorderSide(
                              color: Colors.white, // Border color
                              width: 1.5, // Border width
                            ),
                          ),
                        ),
                        style:
                            const TextStyle(color: Colors.white), // Text color
                        onChanged: (value) {
                          _location = value;
                        },
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0), 
                      child: ElevatedButton(
                        onPressed: _getCurrentLocation,
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
                        child: const Text('Use Current Location'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0), 
                      child: ElevatedButton(
                        onPressed: _pickImage,
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
                        child: const Text('Pick Image'),
                      ),
                    ),
                  ],
                ),

                _image != null
                    ? Image.file(File(_image!.path))
                    : const Text(
                        'No image selected',
                        style: TextStyle(
                          color: Colors.white, 
                        ),
                      ),

                if (_location != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Current Location: $_location",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, 
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
