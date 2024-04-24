// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/delete_button.dart';
import 'package:pvnow/theme/pv_colors.dart';

class MyProduct extends StatefulWidget {
  final String productName;
  final String description;
  final Image image;
  final String vendorName;
  final double price;
  final Timestamp timestamp;
  const MyProduct({
    super.key,
    required this.productName,
    required this.vendorName,
    required this.image,
    required this.price,
    required this.timestamp,
    required this.description,
  });

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  final currentuser = FirebaseAuth.instance.currentUser!;

  void deleteProduct() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          // Cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: pvPurple))),

          // Delete button
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Products')
                  .where('vendorName', isEqualTo: widget.vendorName)
                  .where('productName', isEqualTo: widget.productName)
                  .get()
                  .then(
                (snapshot) {
                  for (DocumentSnapshot doc in snapshot.docs) {
                    doc.reference.delete();
                  }
                },
              );
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: pvPurple)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String price = widget.price.toStringAsFixed(2);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.5, top: 12.5),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: widget.image.image,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                if (widget.vendorName == currentuser.displayName)
                  DeleteButton(
                    onTap: deleteProduct,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
