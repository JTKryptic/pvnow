// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/views/pages/private_storefront.dart';
import 'package:pvnow/views/pages/public_storefront.dart';

class MarketplaceVendor extends StatefulWidget {
  final Image logo;
  final String brandName;
  final String email;
  const MarketplaceVendor(
      {super.key,
      required this.logo,
      required this.brandName,
      required this.email});

  @override
  State<MarketplaceVendor> createState() => _MarketplaceVendorState();
}

class _MarketplaceVendorState extends State<MarketplaceVendor> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  goToStorefront() {
    if (currentUser.email == widget.email) {
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
              brandname: widget.brandName,
              email: widget.email,
              logo: widget.logo),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToStorefront();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: widget.logo.image,
              width: 100,
            ),
            Text(
              widget.brandName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
