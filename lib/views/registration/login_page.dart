// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/admin_drawer.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/theme/pv_colors.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onUserTap;
  final void Function()? onVendorTap;

  const LoginPage(
      {super.key, required this.onUserTap, required this.onVendorTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login function
  void login() async {
    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // logo
              Image.asset(
                'assets/images/logo.png',
                width: 250,
                height: 250,
              ),

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

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Forgot Password")],
              ),

              const SizedBox(height: 25),

              // log in button
              MyButton(
                text: "Log In",
                onTap: login,
                buttonColor: pvPurple,
                textColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),

              // register for user account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onUserTap,
                    child: const Text(
                      " Sign Up Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(212, 167, 253, 1),
                      ),
                    ),
                  )
                ],
              ),

              // register for vendor account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Are you a vendor?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onVendorTap,
                    child: Text(
                      " Register Here",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pvGoldLight,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
