// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: IconThemeData(color: pvGoldLight),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: CustomScrollView(
        slivers: [
          buildBody(),
        ],
      ),
    );
  }

  Widget buildBody() => SliverToBoxAdapter(
        child: SizedBox(
          height: 1000,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyVendor(
                key: UniqueKey(),
                companyName: 'Comp App',
                photo: 'https://picsum.photos/200/300',
                productType: 'Streetwear',
                bio: 'I am a great company',
              ),
              MyVendor(
                key: UniqueKey(),
                companyName: 'Comp App',
                photo: 'https://picsum.photos/200/300',
                productType: 'Streetwear',
                bio: 'I am a great company',
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      );
}

class MyVendor extends StatelessWidget {
  @override
  // ignore: overridden_fields
  final Key? key;
  final String companyName;
  final String photo;
  final String productType;
  final String bio;

  const MyVendor({
    this.key,
    required this.companyName,
    required this.photo,
    required this.productType,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // Your implementation for MyVendor widget
        );
  }
}
