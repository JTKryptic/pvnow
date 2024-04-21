// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/images/logo.png',
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("ADMIN LOGIN"),
              onTap: () {
                Navigator.pushNamed(context, '/adminLogin');
              },
            ),
          ),
        ],
      ),
    );
  }
}
