// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/drawer.dart';

class StorefrontPage extends StatefulWidget {
  const StorefrontPage({super.key});

  @override
  State<StorefrontPage> createState() => _StorefrontPageState();
}

class _StorefrontPageState extends State<StorefrontPage> {
  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storefront"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: [
          IconButton(onPressed: goBack, icon: Icon(Icons.keyboard_return))
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}