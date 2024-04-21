import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/controllers/login_register.dart';
import 'package:pvnow/views/pages/admin_home.dart';
import 'package:pvnow/views/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isAdmin = false;

  toggleIsAdmin(String? id) async {
    final collection = FirebaseFirestore.instance.collection("Admin");
    final doc = await collection.doc(id!).get();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            final currentUser = FirebaseAuth.instance.currentUser!;
            toggleIsAdmin(currentUser.email);
            if (isAdmin) {
              return const AdminHome();
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
