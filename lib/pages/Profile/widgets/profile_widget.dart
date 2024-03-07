import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:wildlifeconnect/pages/Profile/pages/report_crimes.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final color = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        Center(
          child: Stack(
            children: [
              buildImage(),
              Positioned(
                bottom: 0,
                right: 0,
                child: buildEditIcon(Colors.black),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: !isEdit ? buildReportCrimeButton() : const SizedBox(),
        ),
      ],
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.black,
        all: 3,
        child: buildCircle(
          color: Color.fromARGB(255, 23, 176, 54),
          all: 6,
          child: Icon(
            isEdit ? Icons.add_a_photo : null,
            size: 18,
            color: Colors.white,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget buildReportCrimeButton() => SizedBox(
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color.fromARGB(255, 23, 176, 54),
            child: const Icon(Icons.phone_forwarded, color: Colors.white),
          ),
        ),
      );
}
