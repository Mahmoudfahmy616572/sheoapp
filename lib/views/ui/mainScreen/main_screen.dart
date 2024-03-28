// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/main_page_provider.dart';
import 'package:sheoapp/views/ui/cart/cart.dart';
import 'package:sheoapp/views/ui/favourite/favourite.dart';
import 'package:sheoapp/views/ui/home/home.dart';
import 'package:sheoapp/views/ui/profile/profile.dart';

import 'component/bottom_navbar.dart';

List<Widget> pageList = [Home(), Favourite(), Cart(), Profile()];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
        builder: (context, mainPageProvider, child) {
      return Scaffold(
        backgroundColor: Color(0xFFE2E2E2),
        body: pageList[mainPageProvider.pageindex],
        bottomNavigationBar: BottomNavBar(),
      );
    });
  }
}
