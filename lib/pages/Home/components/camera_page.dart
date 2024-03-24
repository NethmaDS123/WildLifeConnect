import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Home/components/prediction_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String? prediction;
  File? _imageFile;
  List<int>? _imageBytes;

  Future<void> _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imageBytes = _imageFile!.readAsBytesSync();
      });
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _imageBytes = _imageFile!.readAsBytesSync();
      });
    }
  }

  Future<void> _identifyAnimal(File? _imageFile) async {
    final uri = Uri.parse(
        'https://wildlifeconnectbackend.onrender.com/identifiers/saveNget');

    const storage = FlutterSecureStorage();
    String? authToken = await storage.read(key: 'jwt_token');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({'Authorization': 'Bearer $authToken'});

    // Add the image file to the request
    var file = await http.MultipartFile.fromPath(
      'image',
      _imageFile!.path,
      contentType:
          MediaType('image', 'jpeg'),
    );
    request.files.add(file);

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String location = responseData['location'];
        print('Image saved successfully at $location');
        getAnimalPrediction(location);
      } else {
        print('Error saving image: ${response.body}');
      }
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> getAnimalPrediction(String location) async {
    try {
      final uri = Uri.parse(
          'https://wildlifeconnect-backend-amft734wkq-de.a.run.app/predict');
      final request = http.Request('POST', uri);
      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      request.body = jsonEncode({"imageUrl": location});

      final http.StreamedResponse response = await request.send();
      final String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = json.decode(responseBody);
        setState(() {
          prediction = responseData['prediction'];
        });
        Get.to(() => PredictionPage(
              imgUrl: location,
              prediction: prediction!,
              imageFile: _imageFile!
            ));
      } else {
        print('Error getting prediction');
      }
    } catch (e) {
      print('Error getting prediction: $e');
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
