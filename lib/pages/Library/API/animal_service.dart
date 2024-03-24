import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wildlifeconnect/pages/Library/API/animalModel.dart';

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
