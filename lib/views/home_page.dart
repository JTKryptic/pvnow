// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final collection = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    String name = currentUser.displayName!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
