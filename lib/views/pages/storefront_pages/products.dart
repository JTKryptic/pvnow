// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/drawer.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Storefront"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        actions: [
          IconButton(onPressed: goBack, icon: Icon(Icons.keyboard_return))
        ],
      ),
      drawer: MyDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Image.asset('lib/images/8.png')
                      //Icon(Icons.propane)
                      ),
                ),
                SizedBox(height: 5),
                //product name
                Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //desc
                //Text("Description of product"),
                //price
                //Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Image.asset('lib/images/5.png')
                      //Icon(Icons.propane)
                      ),
                ),
                SizedBox(height: 5),
                //product name
                Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //desc
                //Text("Description of product"),
                //price
                //Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Image.asset('lib/images/1.png')
                      //Icon(Icons.propane)
                      ),
                ),
                SizedBox(height: 5),
                //product name
                Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //desc
                //Text("Description of product"),
                //price
                //Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Image.asset('lib/images/1.png')
                      //Icon(Icons.propane)
                      ),
                ),
                SizedBox(height: 5),
                //product name
                Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //desc
                //Text("Description of product"),
                //price
                //Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product image
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      padding: EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Image.asset('lib/images/1.png')
                      //Icon(Icons.propane)
                      ),
                ),
                SizedBox(height: 5),
                //product name
                Text(
                  "Product",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                //desc
                //Text("Description of product"),
                //price
                //Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                //product image
                Icon(Icons.propane),
                //product name
                Text("Product", style: TextStyle(fontWeight: FontWeight.bold)),
                //desc
                Text("Description of product"),
                //price
                Text("\$20"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                //product image

                Icon(Icons.propane),
                //product name
                Text("Product", style: TextStyle(fontWeight: FontWeight.bold)),
                //desc
                Text("Description of product"),
                //price
                Text("20"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
