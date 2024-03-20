// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator package
import 'dart:async';

class Location extends StatefulWidget {
  const Location({super.key, required this.title});

  final String title;

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Marker? _userMarker; // Declare _userMarker as nullable

  static const CameraPosition yalaLocation = CameraPosition(
    bearing: 0.0,
    target: LatLng(7.712227821350098, 80.650390625),
    tilt: 0.0,
    zoom: 7.0,
  );

  @override
  void initState() {
    super.initState();
    // Call _getCurrentLocation() when the Location class is initialized
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: yalaLocation,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: _userMarker != null
            ? {_userMarker!}
            : {}, // Check if _userMarker is not null
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
        },
        tooltip: 'Get Current Location',
        child: const Icon(Icons.location_searching),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show dialog or open settings
      return;
    }

    // Check if permission to access location is granted
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Permission to access location is denied, ask for permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission is still denied, show dialog or open settings
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permission is denied forever, handle appropriately.
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Create a marker at the user's current location
    setState(() {
      _userMarker = Marker(
        markerId: const MarkerId(''),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    // Use position data to update the map's camera position
    CameraPosition newPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16.0,
    );

    // Move the camera to the new position
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }
}
