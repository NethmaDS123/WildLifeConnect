import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mime/mime.dart';

// Enum for Rarity
enum Rarity { common, uncommon, rare, epic, legendary }

// Class for Token
class Token {
  final String animalName;
  final File imageFile;
  final String rarity;

  Token(this.animalName, this.imageFile, this.rarity);
}

// Function to generate token
Token generateToken(String animalName, File imageFile) {
  final random = Random();
  final String rarity = _generateRandomRarity(random);

  return Token(animalName, imageFile, rarity);
}

// Function to generate random rarity
String _generateRandomRarity(Random random) {
  // Mapping rarity probabilities
  final rarities = {
    Rarity.common: 0.5,
    Rarity.uncommon: 0.3,
    Rarity.rare: 0.15,
    Rarity.epic: 0.04,
    Rarity.legendary: 0.01,
  };

  // Generate a random value between 0 and 1
  double randomNumber = random.nextDouble();

  // Find the rarity based on the random number
  Rarity selectedRarity = Rarity.common;
  double cumulativeProbability = 0.0;

  for (var entry in rarities.entries) {
    cumulativeProbability += entry.value;
    if (randomNumber <= cumulativeProbability) {
      selectedRarity = entry.key;
      break;
    }
  }

  return selectedRarity.toString().substring(
        7,
      );
}

Color _getRarityColor(String rarity) {
  switch (rarity) {
    case 'common':
      return Colors.grey;
    case 'uncommon':
      return Colors.green;
    case 'rare':
      return Colors.blue;
    case 'epic':
      return Colors.purple;
    case 'legendary':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

class TokenGenerator extends StatefulWidget {
  final String animalName;
  final File imageFile;

  const TokenGenerator({
    Key? key,
    required this.animalName,
    required this.imageFile,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TokenGeneratorState createState() => _TokenGeneratorState();
}

class _TokenGeneratorState extends State<TokenGenerator> {
  Token? _generatedToken;
  bool _isButtonDisabled = false;

  Future<void> _saveToken(Token token) async {
    final uri = Uri.parse('https://wildlifeconnectbackend.onrender.com/tokens/saveToken');

    const storage = FlutterSecureStorage();
    String? authToken = await storage.read(key: 'jwt_token');

    // Create a multipart request
    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({'Authorization': 'Bearer $authToken'});

    // Add the image file to the request
    var file = await http.MultipartFile.fromPath(
      'image',
      token.imageFile.path,
      contentType: MediaType('image', 'jpeg'), // Adjust content type if necessary
    );
    request.files.add(file);

    // Add other form data
    request.fields['animalName'] = token.animalName;
    request.fields['rarity'] = token.rarity;

    try {
      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Token saved successfully
        print('Token saved successfully');
      } else {
        // Error saving token
        print('Error saving token: ${response.body}');
      }
    } catch (e) {
      // Error handling
      print('Error saving token: $e');
    }
  }

  Future<void> _handleButtonPress(String animalName, File imageFile) async {
    setState(() {
      _generatedToken = generateToken(animalName, imageFile);
      _isButtonDisabled = true;
    });

    // Save token to server
    await _saveToken(_generatedToken!);
  }

  @override
  Widget build(BuildContext context) {
    String animalName = widget.animalName;
    File imageFile = widget.imageFile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: _isButtonDisabled ? null : () => _handleButtonPress(animalName, imageFile),
              child: const Text('Generate Token'),
            ),
            const SizedBox(height: 16.0),
            if (_generatedToken != null)
              Container(
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: _getRarityColor(_generatedToken!.rarity),
                      width: 10.0),
                  image: DecorationImage(
                    image: FileImage(_generatedToken!.imageFile),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Card(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${_generatedToken!.animalName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
