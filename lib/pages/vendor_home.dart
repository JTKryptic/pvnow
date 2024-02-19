// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorHomepage extends StatelessWidget {
  const VendorHomepage({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Home"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(212, 167, 253, 1),
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
