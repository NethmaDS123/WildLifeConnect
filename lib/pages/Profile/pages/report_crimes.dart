// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isSidebarOpen = false;
  bool _isFirstToggle = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isFirstToggle) _isFirstToggle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Main content
          Container(
            color: Colors.white,
          ),

          if (_isSidebarOpen && !_isFirstToggle)
            Positioned(
              top: 30, // Adjust the top spacing as needed
              right: 0, // Adjust the right spacing as needed
              bottom: 0, // Extend to the bottom of the screen
              width: 300, // Adjust the width of the sidebar as needed
              child: Container(
                color: const Color.fromRGBO(41, 56, 39, 1.0),
                padding: const EdgeInsets.only(
                    top: 55, left: 10), // Add left padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: _toggleSidebar,
                        ),
                        const Text(
                          'Contact one of the\nfollowing services in\ncase of emergency',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            30), // spacing between main text and emergency contacts
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
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Floating action button for sidebar toggle
          if (!_isSidebarOpen || _isFirstToggle)
            Positioned(
              top: 150,
              right: 0,
              child: Stack(
                children: [
                  SizedBox(
                    width: 60,
                    height: 80,
                    child: FloatingActionButton(
                      onPressed: _toggleSidebar,
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_forwarded,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(height: 2.5),
                          Text(
                            'Report\nCrimes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
