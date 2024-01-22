// ignore_for_file: prefer_const_constructors
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/material.dart';
import 'package:pvnow/auth/auth.dart';
import 'package:pvnow/firebase_options.dart';
import 'package:pvnow/theme/dark_mode.dart';
import 'package:pvnow/theme/light_mode.dart';

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
      home: const AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
