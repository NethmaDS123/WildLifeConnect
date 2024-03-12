import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;
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
          ],
        ),
      ),
    );
  }
}
