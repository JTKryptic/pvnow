// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pvnow/components/bottom_nav.dart';
import 'package:pvnow/components/drawer.dart';
import 'package:pvnow/theme/pv_colors.dart';

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

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
    );
  }
}
