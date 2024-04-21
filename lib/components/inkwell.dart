import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const CustomInkWell({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
