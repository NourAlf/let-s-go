import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:letsgohome/screens/profile.dart';
import 'package:letsgohome/screens/settingsPage.dart';
import '../screens/students_page.dart';

class CustomFancyBottomNavigation extends StatefulWidget {
  const CustomFancyBottomNavigation({Key? key}) : super(key: key);

  @override
  _CustomFancyBottomNavigationState createState() =>
      _CustomFancyBottomNavigationState();
}

class _CustomFancyBottomNavigationState
    extends State<CustomFancyBottomNavigation> {
  int _currentIndex = 1;

  final List<Widget> _pages = const [
    SettingsPage(),
    StudentsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.settings, size: 30, color: Colors.white),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (position) {
          setState(() {
            _currentIndex = position;
          });
        },
        index: _currentIndex,
        height: 50,
        backgroundColor: Colors.white,
        color: const Color(0xFF5C955D),
        animationDuration: const Duration(milliseconds: 60),
      ),
    );
  }
}
