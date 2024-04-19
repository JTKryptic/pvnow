import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart'; // If this is the same as custom_nav_bar, you can remove one
import 'package:pvnow/components/drawer.dart'; // If this is the same as custom_drawer, you can remove one
import 'package:pvnow/theme/pv_colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar:
          AppBar(backgroundColor: Colors.purple, title: Text("List of Posts")),
      drawer: MyDrawer(),
      body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.red,
                  child: Column(
                    children: [
                      
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/1.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      Align(alignment: Alignment.topLeft,),
                      Text("Hey we will be here"),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.orange,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/1.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      Text("Hey we will be here"),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.yellow,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(

                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/1.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      Text("Hey we will be here"),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.green,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/1.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      Text("Hey we will be here"),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/1.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      Text("Hey we will be here"),
                    ],
                  ),
                )),
          ],
        ));
    );
  }
}
