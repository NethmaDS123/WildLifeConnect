import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Map/location_image_map_update.dart';
import 'package:wildlifeconnect/pages/Map/get_user_current_location.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=1527&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            title: const Text(
              'Recent Sightings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.transparent, 
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LocationImageMapUpdate();
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white, 
                    side: const BorderSide(
                      color: Colors.white,
                      width: (1.5)), 
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
                    backgroundColor: Colors.green, 
                    foregroundColor: Colors.white, 
                    side: const BorderSide(
                      color: Colors.white, 
                      width: (1.5)
                      ),
                  ),
                  child: const Text('Get Current Location'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
