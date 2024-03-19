// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
   DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      body: content(),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget content(){
    return Column(
      children: [
        TableCalendar(
          headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          focusedDay: today, 
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),

          )
      ],

    );

  }
}