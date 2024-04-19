import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar:
          AppBar(backgroundColor: Colors.purple, title: Text("Profile Page")),
      drawer: Drawer(),
      body: ListView(children: [
        //image
        Icon(Icons.fax),
        Text("Title of store"),
        Text("About them"),
        Text("contact"),
      ]),
    );
  }
}
