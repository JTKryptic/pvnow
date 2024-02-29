// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
