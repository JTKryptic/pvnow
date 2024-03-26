// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/drawer.dart';

class StorefrontPage extends StatefulWidget {
  const StorefrontPage({super.key});

  @override
  State<StorefrontPage> createState() => _StorefrontPageState();
}

class _StorefrontPageState extends State<StorefrontPage> {
  void goHome() {
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storefront"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: [IconButton(onPressed: goHome, icon: Icon(Icons.home))],
      ),
      drawer: MyDrawer(),
    );
  }
}
