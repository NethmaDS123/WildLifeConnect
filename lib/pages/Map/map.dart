import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Map/RecentSightings.dart';
import 'package:wildlifeconnect/pages/Map/getUserCurrentLocation.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Sightings'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const RecentSightings();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change button color to green
                foregroundColor: Colors.white, // Change font color to white
              ),
              child: const Text('View Recent Sightings'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Location(
                      title: 'Get Current Location',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change button color to green
                foregroundColor: Colors.white, // Change font color to white
              ),
              child: const Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
