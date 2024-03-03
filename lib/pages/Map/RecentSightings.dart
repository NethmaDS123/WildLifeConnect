import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class RecentSightings extends StatefulWidget {
  const RecentSightings({Key? key});

  @override
  State<RecentSightings> createState() => RecentSightingsState();
}

class RecentSightingsState extends State<RecentSightings> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition yalaLocation = CameraPosition(
    bearing: 0.0,
    target: LatLng(7.712227821350098,80.650390625),
    tilt: 0.0,
    zoom: 7.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Sightings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: yalaLocation,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}