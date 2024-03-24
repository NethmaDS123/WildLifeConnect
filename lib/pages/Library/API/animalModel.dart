// ignore_for_file: file_names

class Animal {
  final String id;
  final String conservationStatus;
  final String name;
  final Map<String, dynamic> taxonomy;
  final List<String> locations;
  final Map<String, dynamic> characteristics;
  final String? imageUrl;

  Animal({
    required this.id,
    required this.conservationStatus,
    required this.name,
    required this.taxonomy,
    required this.locations,
    required this.characteristics,
    this.imageUrl,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['_id'],
      conservationStatus: json['conservation_status'],
      name: json['name'],
      taxonomy: json['taxonomy'],
      locations: List<String>.from(json['locations']),
      characteristics: json['characteristics'],
      imageUrl: json['imageUrl'],
    );
  }
}
