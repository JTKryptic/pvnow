// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';

class HumpdayPage extends StatelessWidget {
  const HumpdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Humpday'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
