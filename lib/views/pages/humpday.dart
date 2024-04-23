// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart'; // If this is the same as custom_nav_bar, you can remove one
import 'package:pvnow/components/drawer.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pvnow/theme/pv_colors.dart';
import 'package:pvnow/views/pages/private_storefront.dart';
import 'package:pvnow/views/pages/public_storefront.dart';

class HumpdayPage extends StatefulWidget {
  const HumpdayPage({Key? key}) : super(key: key);

  @override
  State<HumpdayPage> createState() => _HumpdayPageState();
}

class _HumpdayPageState extends State<HumpdayPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  goToStorefront(name) {
    if (currentUser.displayName == name) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PrivateStorefrontPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublicStorefrontPage(
              brandname: name,
              email: currentUser.email!,
              logo: Image.network(currentUser.photoURL!)),
        ),
      );
    }
  }

  DateTime getNextWednesday() {
    DateTime now = DateTime.now();
    int daysUntilWednesday = DateTime.wednesday - now.weekday;
    if (daysUntilWednesday < 0) {
      daysUntilWednesday += 7;
    }
    return now.add(Duration(days: daysUntilWednesday));
  }

  String formatDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Humpday"),
        centerTitle: true,
        iconTheme: IconThemeData(color: pvGoldLight),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: MyDrawer(), // Ensure this is consistent across both snippets
      bottomNavigationBar:
          BottomNavBar(), // Ensure this is consistent across both snippets
      body: Column(
        children: [
          // Your existing UI elements
          Text(
            'Upcoming Humpday: ${formatDate(getNextWednesday())}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/images/mscmap.png',
            width: 300,
            height: 300,
          ),
          Text(
            'Humpday Vendors',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 35,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          // The StreamBuilder from the new code snippet
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Humpday Vendors')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<String> vendorNames = snapshot.data!.docs
                    .map((doc) => doc['approved'] ? doc['name'].toString() : '')
                    .toList();

                return ListView.builder(
                  itemCount: vendorNames.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => goToStorefront(vendorNames[index]),
                      child: Text(
                        vendorNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: pvPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
