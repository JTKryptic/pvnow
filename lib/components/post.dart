// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/delete_button.dart';
import 'package:pvnow/theme/pv_colors.dart';
import 'package:intl/intl.dart';

class MyPost extends StatefulWidget {
  final String message;
  final Image userImage;
  final String user;
  final Timestamp timestamp; // Added timestamp variable
  const MyPost({
    super.key,
    required this.message,
    required this.user,
    required this.userImage,
    required this.timestamp, // Added timestamp parameter
  });

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          // Cancel button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: pvPurple))),

          // Delete button
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Posts')
                  .where('vendorName', isEqualTo: widget.user)
                  .where('timestamp', isEqualTo: widget.timestamp)
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
    String time =
        DateFormat('MMMM d, y – hh:mm a').format(widget.timestamp.toDate());
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.user, // Display user
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                  ),
                ),
                Text(
                  time, // Display timestamp
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Image(
              image: widget.userImage.image,
              width: double.infinity,
            ),
            const SizedBox(height: 15),
            Text(
              widget.message,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: pvPurple,
                      ),
                      onPressed: () {
                        // Handle like button press
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        color: pvPurple,
                      ),
                      onPressed: () {
                        // Handle comment button press
                      },
                    ),
                  ],
                ),
                if (widget.user == currentUser.displayName)
                  DeleteButton(
                    onTap: deletePost,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
