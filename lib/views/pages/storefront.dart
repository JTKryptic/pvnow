import 'package:flutter/material.dart';

import 'storefront_pages/posts.dart';
import 'storefront_pages/products.dart; 
import 'storefront_pages/profile.dart';

class Storefront extends StatelessWidget {
  final _controller = PageController();
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
