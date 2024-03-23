import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Home/home.dart';
import 'package:wildlifeconnect/pages/Library/library.dart';
import 'package:wildlifeconnect/pages/Map/map.dart';
import 'package:wildlifeconnect/pages/Posts/create_post.dart';
import 'package:wildlifeconnect/pages/Profile/pages/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // Define a custom color scheme
  final Color _selectedItemColor = Colors.green[800]!;
  final Color _unselectedItemColor = Colors.grey;
  final double _iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          MapPage(),
          CreatePost(),
          LibraryPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: _iconSize),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, size: _iconSize),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add, size: _iconSize),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book, size: _iconSize),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: _iconSize),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: _unselectedItemColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
