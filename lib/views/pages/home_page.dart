// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/components/post.dart';
import 'package:pvnow/theme/pv_colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final vendorCollection = FirebaseFirestore.instance.collection("Vendors");

  bool isVendor = false;

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

  void addPost() {
    Navigator.pushNamed(context, '/addPost');
  }

  @override
  void initState() {
    if (context.mounted) toggleIsVendor(currentUser.email!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                if (isVendor)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: pvPurple.withOpacity(.4),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: MyButton(
                        text: "Add Post",
                        onTap: addPost,
                        buttonColor: pvPurpleDark,
                        textColor: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Posts')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final posts = snapshot.data!.docs;
                      return Column(
                        children: posts.map((post) {
                          final data = post.data() as Map<String, dynamic>;
                          return MyPost(
                            message: data['description'],
                            user: data['vendorName'],
                            userImage: Image.network(data['image']),
                            timestamp: data['timestamp'],
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                Text(
                  "Logged in as ${currentUser.displayName!}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
