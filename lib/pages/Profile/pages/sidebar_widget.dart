import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 44, 157, 67),
      padding: const EdgeInsets.only(top: 60, left: 5), // Add left padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Contact one of the\nfollowing services in\ncase of emergency',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onPressed: () => {Navigator.pop(context)},
              ),
            ],
          ),
          const SizedBox(
              height: 30), // spacing between main text and emergency contacts
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '●\tDepartment of Wildlife Conservation (Sri Lanka)\n+94 11 2 888 585\n\n'
                  '●\tThe Wildlife & Nature Protection Society\n+94 11 2 887390\n\n'
                  '●\tThe Wilderness & Wildlife Conservation Trust\n+94773544382\n\n'
                  '●\tOtara Foundation\n+94 773 429 025\n\n'
                  '●\tJustice for Animals\njusticeforanimals.lk@gmail.com',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
