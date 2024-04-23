// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/post.dart';

class VendorPosts extends StatefulWidget {
  final String vendorName;
  const VendorPosts({Key? key, required this.vendorName}) : super(key: key);

  @override
  State<VendorPosts> createState() => _VendorPostsState();
}

class _VendorPostsState extends State<VendorPosts> {
  final vendorCollection = FirebaseFirestore.instance.collection("Vendors");

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 20,
            bottom: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Posts')
                    .where('vendorName', isEqualTo: widget.vendorName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    return Column(
                      children: posts.map((post) {
                        final data = post.data() as Map<String, dynamic>;
                        return MyPost(
                          message: data['description'],
                          user: data['vendorName'],
                          userImage: Image.network(data['image']),
                          timestamp: data['timestamp'],
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text("No Vendor Posts");
                  }
                },
              ),
              Text(
                'No more posts',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
