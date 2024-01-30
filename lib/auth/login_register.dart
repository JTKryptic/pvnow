import 'package:flutter/material.dart';
import 'package:pvnow/pages/login_page.dart';
import 'package:pvnow/pages/register_page.dart';
import 'package:pvnow/pages/vendor_registration_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // show login by default
  bool showLoginPage = true;
  bool showVendorRegistration = false;

  // toggle between login and register
  void toggleRegister() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  // toggle between login and register
  void toggleVendorRegister() {
    setState(() {
      showVendorRegistration = !showVendorRegistration;
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onUserTap: toggleRegister,
        onVendorTap: toggleVendorRegister,
      );
    } else if (showVendorRegistration) {
      return VendorRegisterPage(onTap: toggleVendorRegister);
    } else {
      return RegisterPage(onTap: toggleRegister);
    }
  }
}
