// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/vendor_posts.dart';
import 'package:pvnow/components/vendor_products.dart';
import 'package:pvnow/theme/pv_colors.dart';

class PrivateStorefrontPage extends StatefulWidget {
  PrivateStorefrontPage({super.key});

  @override
  State<PrivateStorefrontPage> createState() => _PrivateStorefrontPageState();
}

class _PrivateStorefrontPageState extends State<PrivateStorefrontPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final vendorCollection = FirebaseFirestore.instance.collection("Vendors");
  var phoneNumber;
  var website;
  Map<String, dynamic>? currentUserData = {};

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await vendorCollection.doc(currentUser.email!).get();
    if (snapshot.exists) {
      setState(() {
        currentUserData = snapshot.data();
        phoneNumber = currentUserData!['phoneNumber'];
        website = currentUserData!['website'];
      });
    }
  }

  void addPost() {
    Navigator.pushNamed(context, '/addPost');
  }

  void addProduct() {
    Navigator.pushNamed(context, '/addProduct');
  }

  @override
  Widget build(BuildContext context) {
    String email = currentUser.email!;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Storefront"),
          centerTitle: true,
          iconTheme: IconThemeData(color: pvGoldLight),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          actions: [
            IconButton(onPressed: addPost, icon: Icon(Icons.add_a_photo)),
            IconButton(
                onPressed: addProduct, icon: Icon(Icons.add_shopping_cart)),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              Image.network(
                                currentUser.photoURL!,
                                width: 175,
                              ),
                              Text(
                                currentUser.displayName!,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              Text('Email: $email',
                                  style: TextStyle(color: Colors.grey)),
                              Text('Website: $website',
                                  style: TextStyle(color: Colors.grey)),
                              Text('Phone Number: $phoneNumber',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                expandedHeight: 380.0,
                bottom: TabBar(
                  labelColor: pvPurple,
                  indicatorColor: pvPurple,
                  dividerColor: Theme.of(context).colorScheme.primary,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.camera_alt),
                      text: "Posts",
                    ),
                    Tab(
                      icon: Icon(Icons.shopping_cart),
                      text: "Products",
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              VendorPosts(
                vendorName: currentUser.displayName!,
              ),
              VendorProducts(
                vendorName: currentUser.displayName!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
