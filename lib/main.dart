// ignore_for_file: prefer_const_constructors
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:pvnow/controllers/auth.dart';
import 'package:pvnow/firebase_options.dart';
import 'package:pvnow/theme/dark_mode.dart';
import 'package:pvnow/views/pages/add_post.dart';
import 'package:pvnow/views/pages/admin_home.dart';
import 'package:pvnow/views/pages/home_page.dart';
import 'package:pvnow/views/pages/storefront.dart';
import 'package:pvnow/views/registration/admin_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: darkMode,
      darkTheme: darkMode,
      routes: {
        '/adminHome': (context) => AdminHome(),
        '/adminLogin': (context) => AdminLoginPage(),
        '/storefront': (context) => StorefrontPage(),
        '/home': (context) => Homepage(),
        '/addPost': (context) => AddPost(),
      },
    );
  }
}
