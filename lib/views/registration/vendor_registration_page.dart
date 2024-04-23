// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:pvnow/components/button.dart';
import 'package:pvnow/components/helper_functions.dart';
import 'package:pvnow/components/textfield.dart';
import 'package:pvnow/theme/pv_colors.dart';
import 'package:pvnow/views/registration/vendor_information.dart';

class VendorRegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const VendorRegisterPage({super.key, required this.onTap});

  @override
  State<VendorRegisterPage> createState() => _VendorRegisterPageState();
}

class _VendorRegisterPageState extends State<VendorRegisterPage> {
  // text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // register function
  void next() async {
    // make sure passwords match
    if (passwordController.text != confirmPwController.text) {
      // notify users that the passwords do not match
      displayMessageToUser("Passwords don't match!", context);
    }

    // if passwords match
    else {
      // navigate to the VendorInformationPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VendorInformationPage(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
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

                Text(
                  "Vendor Registration",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // name
                MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: nameController,
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

                const SizedBox(height: 25),

                // register button
                MyButton(
                  text: "Next",
                  onTap: next,
                  buttonColor: pvPurple,
                  textColor: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 25),

                // Back to login button
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
