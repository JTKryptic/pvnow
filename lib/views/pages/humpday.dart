import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart'; // If this is the same as custom_nav_bar, you can remove one
import 'package:pvnow/components/drawer.dart'; // If this is the same as custom_drawer, you can remove one
import 'package:pvnow/theme/pv_colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class HumpdayPage extends StatelessWidget {
  const HumpdayPage({Key? key}) : super(key: key);

  DateTime getNextWednesday() {
    DateTime now = DateTime.now();
    int daysUntilWednesday = DateTime.wednesday - now.weekday;
    if (daysUntilWednesday < 0) {
      daysUntilWednesday += 7;
    }
    return now.add(Duration(days: daysUntilWednesday));
  }

  String formatDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Humpday"),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
    ),
    drawer: MyDrawer(), // Ensure this is consistent across both snippets
    bottomNavigationBar: BottomNavBar(), // Ensure this is consistent across both snippets
    body: Column(
      children: [
        // Your existing UI elements
        Text(
          'Upcoming Humpday: ${formatDate(getNextWednesday())}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        Image.asset('assets/images/mscmap.png',
        width: 300,
        height: 300,
        ),
        Text(
          'Humpday Vendors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            fontSize: 35,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

        // The StreamBuilder from the new code snippet
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Humpday Vendors').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

                List<String> vendorNames = snapshot.data!.docs.map((doc) => doc['name'].toString()).toList();


              return ListView.builder(
                itemCount: vendorNames.length,
                itemBuilder: (context, index) {
                  return Text(
                    vendorNames[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color.fromARGB(255, 176, 12, 182),
                    ),
                    textAlign: TextAlign.center,
                    
                    );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
}