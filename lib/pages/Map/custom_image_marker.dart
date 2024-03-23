import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class CustomImageMarker extends StatefulWidget {
  final String? location;
  final XFile? image;

  const CustomImageMarker({Key? key, this.location, this.image, String? imageUrl}) : super(key: key);

  @override
  State<CustomImageMarker> createState() => _CustomImageMarkerState();
}

class _CustomImageMarkerState extends State<CustomImageMarker> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition middleofSl = CameraPosition(
    bearing: 0.0,
    target: LatLng(7.812227821350098, 80.740390625),
    tilt: 0.0,
    zoom: 7.5,
  );

  final Set<Marker> myMarker = {};

  Future<Uint8List> _resizeImage(Uint8List imageData) async {
    // Adjust the width and height as needed
    final int maxSize = 35;

    final compressedImage = await FlutterImageCompress.compressWithList(
      imageData,
      minHeight: maxSize,
      minWidth: maxSize,
    );

    return Uint8List.fromList(compressedImage!);
  }

  Future<void> _loadData() async {
    if (widget.image != null && widget.location != null) {
      final Uint8List byteData = await widget.image!.readAsBytes();
      final Uint8List imageData = byteData.buffer.asUint8List();
      final Uint8List resizedImageData = await _resizeImage(imageData);

      final List<String> locationSplit = widget.location!.split(',');
      final double latitude = double.tryParse(locationSplit[0]) ?? 0.0;
      final double longitude = double.tryParse(locationSplit[1]) ?? 0.0;

      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy/MM/dd').format(now);
      String formattedTime = DateFormat.Hm().format(now);

      String title = 'Located on: $formattedDate at $formattedTime h';

      myMarker.add(Marker(
        markerId: MarkerId('0'),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.fromBytes(resizedImageData),
        infoWindow: InfoWindow(title: title),
      ));

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Sightings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(myMarker),
        // markers: _markers,
        initialCameraPosition: middleofSl,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
