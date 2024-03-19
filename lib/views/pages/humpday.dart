// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

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
      'Locstar Hairstyles',
      'Ten/18 Apparel',
      'Makeup By K',

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
            Text(
            DateTime.now().toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
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
                            fontSize: 35,
                            decoration: TextDecoration.underline,
                            shadows: [
                              Shadow(blurRadius: 20.0,
                              color: Colors.purple,
                              offset: Offset(0.0, 0.0),
                              ),
                            ],
                            
                            

                          ),
                          textAlign: TextAlign.center,
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
