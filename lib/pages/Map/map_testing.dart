import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapIntegration extends StatefulWidget {
  const MapIntegration({Key? key});

  @override
  State<MapIntegration> createState() => MapIntegrationState();
}

class MapIntegrationState extends State<MapIntegration> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition yalaLocation = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.4913811683654785,81.4261703491211),
      tilt: 0.0,
      zoom: 14.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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