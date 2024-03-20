import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';

// String getBackendUrl() {
//   if (Platform.isAndroid) {
//     // Use 10.0.2.2 for Android emulator
//     return 'http://10.0.2.2:3000';
//   } else if (Platform.isIOS) {
//     // Use localhost for iOS simulator
//     return 'http://localhost:3000';
//   } else {
//     // Fallback for other platforms
//     return 'http://your-production-url.com';
//   }
// }

Future<List<Animal>> fetchAnimals() async {
  final response = await http
      .get(Uri.parse('https://wildlifeconnectbackend.onrender.com/animals'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Animal> animals =
        body.map((dynamic item) => Animal.fromJson(item)).toList();
    return animals;
  } else {
    throw Exception('Failed to load animals');
  }
}
