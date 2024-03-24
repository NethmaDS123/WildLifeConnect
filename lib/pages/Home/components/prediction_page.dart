import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () => Get.back(),
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Leopard',
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
            child: const Image(
              image: NetworkImage(
                'https://w0.peakpx.com/wallpaper/688/907/HD-wallpaper-young-leopard-colors-landscape-nature.jpg',
              ),
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
            onPressed: () => {},
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
            onPressed: () => {},
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
            onPressed: () => {},
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
