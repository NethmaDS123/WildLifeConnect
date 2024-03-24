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
                'Token Information',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () => {Navigator.pop(context)},
              ),
            ],
          ),
          const SizedBox(
              height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tokens exist in the following rarities \n(in descending order)\n\n●\tLegendary (Orange)\n●\tEpic (Purple)\n●\tRare (Blue)\n●\tUncommon (Green)\n●\tCommon (Grey)\n\n'
                  'The chances of getting higher ranked \ntokens are lower the higher the rank\n\n'
                  'The exact percentages are:\n\n●\tLegendary - 1%\n●\tEpic - 4%\n●\tRare - 15%\n●\tUncommon - 30%\n●\tCommon - 50%\n\n',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 255, 255, 255),
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
