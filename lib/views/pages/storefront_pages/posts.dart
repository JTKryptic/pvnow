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
     backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.purple, title: Text("List of Posts")),
        drawer: Drawer(),
        body: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.grey[600],
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
                      SizedBox(
                        child: Text(
                          "Hey we will be here",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  //opacity: .5,
                  color: Colors.grey[600],
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/2.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      SizedBox(
                        child: Text(
                          "Hey we will be here",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.grey[600],
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/3.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      SizedBox(
                        child: Text(
                          "Hey we will be here",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 250,
                  color: Colors.grey[600],
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            padding: EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            child: Image.asset('lib/images/4.png')
                            //Icon(Icons.propane)
                            ),
                      ),
                      SizedBox(
                        child: Text(
                          "Hey we will be here",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        )
    );
  }
}
