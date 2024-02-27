import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  Future<void> _openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the captured image here
    }
  }

  Future<void> _openGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the selected image here
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
          ],
        ),
      ),
    );
  }
}
