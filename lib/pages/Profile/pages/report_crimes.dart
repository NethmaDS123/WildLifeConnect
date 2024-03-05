import 'package:flutter/material.dart';

void main() {
  runApp(const SideBar());
}

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          Container(
            color: Colors.white,
          ),
          
          // Contents of the SideBar
          if (_isSidebarOpen && !_isFirstToggle)
            Positioned(
              top: 30,
              right: 0,
              bottom: 0,
              width: 300,
              child: Container(
                color: const Color.fromRGBO(41, 56, 39, 1.0),
                padding: const EdgeInsets.only(top: 55, left: 10),
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
                            30), // spacing between main title-text and contacts
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

          // Button for report crimes sidebar
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
