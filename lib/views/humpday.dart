// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class HumpdayPage extends StatefulWidget {
  const HumpdayPage({super.key});

  @override
  State<HumpdayPage> createState() => _HumpdayPageState();
}

class _HumpdayPageState extends State<HumpdayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Humpday"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
