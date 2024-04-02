// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final MainAxisAlignment mainAxisAlignment;

  const TitleText({
    super.key,
    required this.text,
    required this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
