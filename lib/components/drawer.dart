// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final collection = FirebaseFirestore.instance.collection("Vendors");

  bool isVendor = false;

  void logout() {
    setState(() {
      FirebaseAuth.instance.signOut();
    });
  }

  toggleIsVendor(String? id) async {
    final doc = await collection.doc(id!).get();

    if (doc.exists == true && context.mounted) {
      setState(() {
        isVendor = true;
      });
    } else {
      setState(() {
        isVendor = false;
      });
    }
  }

  @override
  void initState() {
    if (context.mounted) toggleIsVendor(currentUser.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // List of Pages
          Column(
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
                  title: Text("SETTINGS"),
                ),
              ),
              if (!isVendor)
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text("ACCOUNT"),
                  ),
                ),
              if (isVendor)
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.store),
                    title: Text("MY STOREFRONT"),
                    onTap: () {
                      Navigator.pushNamed(context, '/storefront');
                    },
                  ),
                ),
              if (isVendor)
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text("REGISTER FOR HUMPDAY"),
                    onTap: () {
                      Navigator.pushNamed(context, '/humpdayRegister');
                    },
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 25),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(
                "LOGOUT",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
