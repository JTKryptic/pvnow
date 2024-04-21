// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pvnow/views/pages/storefront_pages/products.dart';

import 'storefront_pages/posts.dart';
import 'storefront_pages/profile.dart';

class StorefrontPage extends StatelessWidget {
  final _controller = PageController();

  StorefrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          Posts(),
          Profile(),
          Products(),
        ],
      ),
    );
  }
}
