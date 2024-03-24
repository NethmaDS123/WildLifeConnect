import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
  // ignore: unused_field
  List<int>? _imageBytes; // Variable to store image bytes

  Future<void> _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imageBytes = _imageFile!.readAsBytesSync(); // Reading image bytes
      });
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imageBytes = _imageFile!.readAsBytesSync(); // Reading image bytes
      });
    }
  }

  Future<void> _identifyAnimal(File? _imageFile) async {
  final uri = Uri.parse('https://wildlifeconnectbackend.onrender.com/identifiers/saveNget');

  const storage = FlutterSecureStorage();
  String? authToken = await storage.read(key: 'jwt_token');

  // Create a multipart request
  var request = http.MultipartRequest('POST', uri);

  request.headers.addAll({'Authorization': 'Bearer $authToken'});

  // Add the image file to the request
  var file = await http.MultipartFile.fromPath(
    'image',
    _imageFile!.path,
    contentType: MediaType('image', 'jpeg'), // Adjust content type if necessary
  );
  request.files.add(file);

  try {
    // Send the request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // Token saved successfully
      final responseData = json.decode(response.body);
      String location = responseData['location'];
      print('Image saved successfully at $location');
      // Now you can use the 'location' variable as needed.
    } else {
      // Error saving token
      print('Error saving image: ${response.body}');
    }
  } catch (e) {
    // Error handling
    print('Error saving image: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _openCamera(context),
              child: const Text('Camera'),
            ),
            ElevatedButton(
              onPressed: () => _openGallery(context),
              child: const Text('Gallery'),
            ),
            const SizedBox(height: 20),
            if (_imageFile != null)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _identifyAnimal(_imageFile),
                  child: const Text('Identify Animal'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
