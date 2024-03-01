// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/theme/pv_colors.dart';
import 'package:pvnow/views/pages/calendar.dart';
import 'package:pvnow/views/pages/home_page.dart';
import 'package:pvnow/views/pages/humpday.dart';
import 'package:pvnow/views/pages/marketplace.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    });
  }

  final List _pages = [
    Homepage(),
    MarketplacePage(),
    HumpdayPage(),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Marketplace',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage("assets/icons/camel.png")),
          label: 'Humpday',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Calendar',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: pvGoldDark,
      unselectedItemColor: pvPurple,
      onTap: _onItemTapped,
    );
  }
}
