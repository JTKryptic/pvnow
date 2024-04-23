// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/theme/pv_colors.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop loading circle
      if (mounted) Navigator.pop(context);

      final currentUser = FirebaseAuth.instance.currentUser!;
      final collection = FirebaseFirestore.instance.collection("Admin");
      final doc = await collection.doc(currentUser.email!).get();

      if (doc.exists == false && context.mounted) {
        setState(() {
          displayMessageToUser("Admin account not recognized", context);
          FirebaseAuth.instance.signOut();
        });
      } else {
        currentUser.updateDisplayName(doc.data()!['name']);
        Navigator.pop(context);
      }
    }

    // display any errors
    on FirebaseAuthException catch (e) {
      // display error message to user
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // logo
            SizedBox(height: 50),
            Image.asset(
              'assets/images/logo.png',
              width: 250,
              height: 250,
            ),
            Text(
              'Admin Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: emailController,
            ),

            const SizedBox(height: 10),

            // password
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 16.0),
            MyButton(
                text: "Login",
                onTap: login,
                buttonColor: pvPurple,
                textColor: Colors.black)
          ],
        ),
      ),
    );
  }
}
