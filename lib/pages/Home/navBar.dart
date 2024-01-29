// import 'package:flutter/material.dart';

// class navBar extends StatelessWidget {
//   const navBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
//         // BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
//         // BottomNavigationBarItem(icon: Icon(Icons.book), label: 'library'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
