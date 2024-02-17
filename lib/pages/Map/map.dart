import 'package:flutter/material.dart';
import 'map_testing.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Sightings'),
      ),
      body: const MapIntegration(),
    );
  }
}
