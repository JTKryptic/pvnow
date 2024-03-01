// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/theme/pv_colors.dart';

class VendorRegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const VendorRegisterPage({super.key, required this.onTap});

  @override
  State<VendorRegisterPage> createState() => _VendorRegisterPageState();
}

class _VendorRegisterPageState extends State<VendorRegisterPage> {
  // text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // register function
  void registerUser() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // make sure passwords match
    if (passwordController.text != confirmPwController.text) {
      // Pop loading circle
      Navigator.pop(context);

      // notify users that the passwords do not match
      displayMessageToUser("Passwords don't match!", context);
    }

    // if passwords match
    else {
      try {
        // try to create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        userCredential.user!.updateDisplayName(nameController.text);

        // create user document and add to firestore database
        createVendorDocument(
            userCredential, nameController.text, brandnameController.text);

        // Pop loading circle
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Pop loading circle
        Navigator.pop(context);

        // display error message to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createVendorDocument(
      UserCredential? userCredential, String name, String brandname) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Vendors")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'name': name,
        'brandname': brandname,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),

                // name
                MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: nameController,
                ),

                const SizedBox(height: 10),

                // name
                MyTextField(
                  hintText: "Brand Name",
                  obscureText: false,
                  controller: brandnameController,
                ),

                const SizedBox(height: 10),

                // email
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

                const SizedBox(height: 10),

                // confirm password
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController,
                ),

                const SizedBox(height: 10),

                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Forgot Password")],
                ),

                const SizedBox(height: 25),

                // register button
                MyButton(
                  text: "Register",
                  onTap: registerUser,
                  buttonColor: pvPurple,
                  textColor: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 25),

                // register button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(212, 167, 253, 1),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
