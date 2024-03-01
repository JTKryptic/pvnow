// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pvnow/theme/pv_colors.dart';

class MyPost extends StatelessWidget {
  final String message;
  final Image userImage;
  final String user;
  const MyPost({
    super.key,
    required this.message,
    required this.user,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: pvPurple.withOpacity(.4),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: userImage.image,
                width: 340,
              ),
              const SizedBox(height: 15),
              Text(
                user,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 20,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
