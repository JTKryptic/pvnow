// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/vendor_posts.dart';
import 'package:pvnow/components/vendor_products.dart';
import 'package:pvnow/theme/pv_colors.dart';

class PublicStorefrontPage extends StatefulWidget {
  final Image logo;
  final String brandname;
  final String email;
  PublicStorefrontPage(
      {super.key,
      required this.brandname,
      required this.email,
      required this.logo});

  @override
  State<PublicStorefrontPage> createState() => _PublicStorefrontPageState();
}

class _PublicStorefrontPageState extends State<PublicStorefrontPage> {
  final vendorCollection = FirebaseFirestore.instance.collection("Vendors");
  Map<String, dynamic>? currentVendorData = {};
  var phoneNumber;
  var website;

  @override
  void initState() {
    super.initState();
    fetchVendor();
  }

  void fetchVendor() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await vendorCollection.doc(widget.email).get();
    if (snapshot.exists) {
      setState(() {
        currentVendorData = snapshot.data();
        phoneNumber = currentVendorData!['phoneNumber'];
        website = currentVendorData!['website'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Storefront"),
          centerTitle: true,
          iconTheme: IconThemeData(color: pvGoldLight),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                              Image(
                                image: widget.logo.image,
                                width: 175,
                              ),
                              Text(
                                widget.brandname,
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
                vendorName: widget.brandname,
              ),
              VendorProducts(
                vendorName: widget.brandname,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
