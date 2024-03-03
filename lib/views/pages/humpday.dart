// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class HumpdayPage extends StatelessWidget {
  const HumpdayPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of menu items
    List<String> menuItems = [
      'Vendor 1',
      'Vendor 2',
      'Vendor 3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Humpday"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,          
          children: [
            // Add an image to the top half of the page
            Image.asset('assets/images/mscmap.png'),
      
            // Scrollable menu
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                shrinkWrap: true,

                children: menuItems
                    .map((item) => Text(
                          item,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 55,

                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
