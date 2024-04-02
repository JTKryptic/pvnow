// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:pvnow/theme/pv_colors.dart';

class DeleteButton extends StatelessWidget {
  final void Function()? onTap;
  DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.5, right: 12.5),
      child: GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.delete,
            color: pvPurpleDark,
          )),
    );
  }
}
