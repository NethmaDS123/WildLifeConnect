import 'package:flutter/material.dart';

class PredictionPage extends StatelessWidget {
  final String imgUrl;
  final String prediction;

  const PredictionPage({
    Key? key,
    required this.imgUrl,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              prediction,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 400,
            width: 600,
            child: Image(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => {}, // Add Button1 logic
            child: Text(
              'Button1',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => {}, // Add Button2 logic
            child: Text(
              'Button2',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => {}, // Add Button3 logic
            child: Text(
              'Button3',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Poppins'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 23, 176, 54),
            ),
          ),
        ],
      ),
    );
  }
}
