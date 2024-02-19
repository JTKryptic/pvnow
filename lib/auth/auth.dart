import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/auth/login_register.dart';
import 'package:pvnow/pages/home_page.dart';
import 'package:pvnow/pages/vendor_home.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final collection = FirebaseFirestore.instance.collection("Vendors");
  bool isVendor = false;

  // function to toggle isVendor boolean to display Vendor Home
  displayVendorHome(String? id) async {
    final doc = await collection.doc(id!).get();

    if (doc.exists == true) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            displayVendorHome(snapshot.data!.email);
            if (isVendor) {
              return const VendorHomepage();
            } else {
              return const Homepage();
            }
          }
          // user is not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
