// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    approveVendors(QueryDocumentSnapshot<Object?> doc) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Approve Vendor?'),
          content: Text(
              'Are you sure you want to approve ${doc['name']} for Humpday? They must have already paid via Panther Marketplace'),
          actions: [
            // Cancel button
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: pvGoldDark))),

            // Approve button
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Humpday Vendors')
                    .doc(doc.id)
                    .update({'approved': true});
                Navigator.pop(context);
              },
              child: Text("Approve", style: TextStyle(color: pvPurple)),
            ),
          ],
        ),
      );
    }

    removeVendorApproval(QueryDocumentSnapshot<Object?> doc) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Remove Approval?'),
          content: Text(
              'Are you sure you want to remove humpday approval for ${doc['name']}?'),
          actions: [
            // Cancel button
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: pvGoldDark))),

            // Approve button
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Humpday Vendors')
                    .doc(doc.id)
                    .update({'approved': false});
                Navigator.pop(context);
              },
              child: Text("Remove Approval", style: TextStyle(color: pvPurple)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Approve Vendors"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          child: PageView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Registered Vendors',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: pvPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Humpday Vendors')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final vendors = snapshot.data!.docs;
                            return Column(
                              children: vendors.map((doc) {
                                final data = doc.data() as Map<String, dynamic>;
                                if (!data['approved']) {
                                  return ListTile(
                                    title: Text(doc['name']),
                                    trailing: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                pvPurple),
                                      ),
                                      onPressed: () => approveVendors(doc),
                                      child: Text('Approve'),
                                    ),
                                  );
                                }
                                return Container();
                              }).toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Approved Vendors',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: pvPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Humpday Vendors')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final vendors = snapshot.data!.docs;
                            return Column(
                              children: vendors.map((doc) {
                                final data = doc.data() as Map<String, dynamic>;
                                if (data['approved']) {
                                  return ListTile(
                                    title: Text(doc['name']),
                                    trailing: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                pvGoldDark),
                                      ),
                                      onPressed: () =>
                                          removeVendorApproval(doc),
                                      child: Text('Remove Approval'),
                                    ),
                                  );
                                }
                                return Container();
                              }).toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.blue,
                child: Center(
                  child: Text("Page 2"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
