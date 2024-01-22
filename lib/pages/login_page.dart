// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // login function
  void login() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    }

    // display any errors
    on FirebaseAuthException catch (e) {
      // Pop loading circle
      if (context.mounted) Navigator.pop(context);

      // display error message to user
      if (context.mounted) displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                'assets/icons/logo.png',
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

              // sign in button
              MyButton(
                text: "Log In",
                onTap: login,
                buttonColor: Color.fromRGBO(212, 167, 253, 1),
                textColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),

              // register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Register Here",
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
    );
  }
}
