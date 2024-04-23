// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pvnow/components/products.dart';

class VendorProducts extends StatefulWidget {
  final String vendorName;
  const VendorProducts({Key? key, required this.vendorName}) : super(key: key);

  @override
  State<VendorProducts> createState() => _VendorProductsState();
}

class _VendorProductsState extends State<VendorProducts> {
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
                    .collection('Products')
                    .where('vendorName', isEqualTo: widget.vendorName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final posts = snapshot.data!.docs;
                    return Column(
                      children: posts.map((post) {
                        final data = post.data() as Map<String, dynamic>;
                        return MyProduct(
                          productName: data['productName'],
                          description: data['description'],
                          image: Image.network(data['imageUrl']),
                          vendorName: data['vendorName'],
                          price: data['price'],
                          timestamp: data['timestamp'],
                        );
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('');
                  }
                },
              ),
              Text(
                'No more products',
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
