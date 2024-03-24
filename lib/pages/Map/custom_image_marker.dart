import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CustomImageMarker extends StatefulWidget {
  final String? location;
  final XFile? image;

  const CustomImageMarker({Key? key, this.location, this.image})
      : super(key: key);

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

  Future<Uint8List> _processImageForMarker(Uint8List imageData) async {
    // Decode the image using the 'image' package
    img.Image? image = img.decodeImage(imageData);
    if (image == null)
      return Uint8List(0); // Return an empty Uint8List if decoding fails

    // Resize the image to a square based on the smaller dimension to maintain aspect ratio
    int size = image.width < image.height ? image.width : image.height;
    img.Image resizedImage = img.copyResizeCropSquare(image, size);

    // Optionally: Further compress the image here if needed

    // Create a circular cropped version of the image
    img.Image circularImage =
        img.copyResize(resizedImage, width: 120, height: 120);

    // Adding a simple white border
    img.drawCircle(circularImage, 60, 60, 60, img.getColor(255, 255, 255, 255));

    // Encode the image back to Uint8List
    return Uint8List.fromList(img.encodePng(circularImage));
  }

  Future<void> _loadData() async {
    if (widget.image != null && widget.location != null) {
      final Uint8List byteData = await widget.image!.readAsBytes();
      final Uint8List resizedImageData = await _processImageForMarker(byteData);

      if (resizedImageData.isNotEmpty) {
        final List<String> locationSplit = widget.location!.split(',');
        final double latitude = double.tryParse(locationSplit[0]) ?? 0.0;
        final double longitude = double.tryParse(locationSplit[1]) ?? 0.0;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy/MM/dd').format(now);
        String formattedTime = DateFormat.Hm().format(now);

        String title = 'Located on: $formattedDate at $formattedTime h';

        final Marker marker = Marker(
          markerId: MarkerId('UniqueID'), // Ensure this is unique
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.fromBytes(resizedImageData),
          infoWindow: InfoWindow(title: title),
        );

        setState(() {
          myMarker.add(marker);
        });
      } else {
        print("Image data could not be processed");
      }
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
