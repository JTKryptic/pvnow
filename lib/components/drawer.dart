// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/theme/pv_colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final vendorCollection = FirebaseFirestore.instance.collection("Vendors");
  final adminCollection = FirebaseFirestore.instance.collection("Admin");
  final humpdayCollection =
      FirebaseFirestore.instance.collection("Humpday Vendors");

  bool isVendor = false;
  bool isAdmin = false;
  bool isRegistered = false;

  void logout() {
    setState(() {
      FirebaseAuth.instance.signOut();
    });
  }

  toggleIsVendor(String? id) async {
    final doc = await vendorCollection.doc(id!).get();

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

  toggleIsAdmin(String? id) async {
    final doc = await adminCollection.doc(id!).get();

    if (doc.exists == true && context.mounted) {
      setState(() {
        isAdmin = true;
      });
    } else {
      setState(() {
        isAdmin = false;
      });
    }
  }

  toggleIsRegistered(String? id) async {
    final doc = await humpdayCollection.doc(id!).get();

    if (doc.exists == true && context.mounted) {
      setState(() {
        isRegistered = true;
      });
    } else {
      setState(() {
        isRegistered = false;
      });
    }
  }

  void registerForHumday() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Register For Humpday'),
        content:
            const Text('Would you like to register for the upcoming Humday?'),
        actions: [
          // Cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: pvPurple))),

          // Delete button
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Humpday Vendors')
                  .doc(currentUser.displayName)
                  .set({
                'name': currentUser.displayName,
                'approved': false,
              });
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('You have registered!'),
                  content: const Text(
                      'Make sure you pay for your tablespace on Panther Marketplace to be approved!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK", style: TextStyle(color: pvPurple)),
                    ),
                  ],
                ),
              );
            },
            child: Text("Register", style: TextStyle(color: pvPurple)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (context.mounted) toggleIsVendor(currentUser.email!);
    if (context.mounted) toggleIsRegistered(currentUser.displayName!);
    if (context.mounted) toggleIsAdmin(currentUser.email!);
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
              if (!isVendor && !isAdmin)
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
              if (isVendor && !isRegistered)
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text("REGISTER FOR HUMPDAY"),
                    onTap: registerForHumday,
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
