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

  Marker? _userMarker;

  static const CameraPosition yalaLocation = CameraPosition(
    bearing: 0.0,
    target: LatLng(7.712227821350098, 80.650390625),
    tilt: 0.0,
    zoom: 7.0,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Get Current Location',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.black, 
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: yalaLocation,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: _userMarker != null
            ? {_userMarker!}
            : {}, 
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
    
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, show dialog
      return;
    }

    // Check if permission to access location is granted
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // permission to access location is denied, ask for permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // if permission is still denied, show dialog or open settings
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
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

    CameraPosition newPosition = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 16.0,
    );

    // Move the camera to the new position
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }
}
