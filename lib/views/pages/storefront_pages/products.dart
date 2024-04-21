// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/drawer.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
