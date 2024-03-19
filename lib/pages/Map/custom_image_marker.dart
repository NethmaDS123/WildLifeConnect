import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart'; // used to format the date and time

class CustomImageMarker extends StatefulWidget {
  const CustomImageMarker({super.key});

  @override
  State<CustomImageMarker> createState() => _CustomImageMarkerState();
}

class _CustomImageMarkerState extends State<CustomImageMarker> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // specifying the  camera position when loading in
  static const CameraPosition middleofSl = CameraPosition(
    bearing: 0.0,
    target: LatLng(7.812227821350098, 80.740390625),
    tilt: 0.0,
    zoom: 7.5,
  );

  final Set<Marker> myMarker = {}; // the set to hold markers

  // list of the location points
  List<LatLng> myPoints = [
    const LatLng(7.712227821350098, 80.650390625),
    const LatLng(8.112227821350098, 80.650390625),
  ];

  // function to load the image data from a network path
  Future<Uint8List> forLoadingNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData (
      format: ui.ImageByteFormat.png
    );

    return byteData!.buffer.asUint8List();
  }

  // function to load marker data
  onLoadData() async {
    for (int a = 0; a < myPoints.length; a++) {
      Uint8List? image = await forLoadingNetworkImage(
          'https://th.bing.com/th/id/R.838c95b2dc0bfe6e568739a88287a8d2?rik=rpPEvsnT7ivQsQ&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fcow-head-silhouette%2fcow-head-silhouette-21.png&ehk=EuCm20nK7KjHZNsNMI4i%2bIEqVTzsVc00P7V0Qs3UMuU%3d&risl=&pid=ImgRaw&r=0');

      // instantiate ImageCodec to decode the image's data
      final ui.Codec imageCodecMarker = await ui.instantiateImageCodec(
        image.buffer.asUint8List(),
        targetHeight: 35,
        targetWidth: 35,
      );

      final ui.FrameInfo frameInfo = await imageCodecMarker.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      // resizing image 
      final Uint8List imageMarkerResized = byteData!.buffer.asUint8List();

      // getting the current time and format it
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy/MM/dd').format(now);
      String formattedTime = DateFormat.Hm().format(now);

      // add formatted time to the title
      String title = 'Located on: $formattedDate at $formattedTime h';

      // adding marker to the set
      myMarker.add(Marker(
          markerId: MarkerId(a.toString()),
          position: myPoints[a],
          icon: BitmapDescriptor.fromBytes(imageMarkerResized),
          infoWindow: InfoWindow(
            title: title,
          )));
      setState(() {
        // updating the current UI to include the data
      });
    }
  }

  @override
  void initState() {
    super.initState();
    onLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Sightings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: Set<Marker>.of(myMarker), // setting the markers on the Google Map
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
