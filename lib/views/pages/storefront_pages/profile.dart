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
        Image.asset('lib/images/9.png'),
        Text("Ten18 Apperal",
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.grey)),
        Text("About them", style: TextStyle(color: Colors.grey)),
        Text("contact", style: TextStyle(color: Colors.grey))
     
      ]),
    );
  }
}
