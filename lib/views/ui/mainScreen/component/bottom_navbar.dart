import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sheoapp/controller/main_page_provider.dart';
import 'package:sheoapp/views/ui/mainScreen/component/bottom_appbar_widget.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
        builder: (context, mainPageProvider, child) {
      return SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.black),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            BottomAppBarWidget(
              icon: mainPageProvider.pageindex == 0
                  ? Ionicons.home
                  : Ionicons.home_outline,
              ontap: () {
                mainPageProvider.pageindex = 0;
              },
            ),
            BottomAppBarWidget(
              icon: mainPageProvider.pageindex == 1
                  ? Ionicons.heart_circle
                  : Ionicons.heart_circle_outline,
              ontap: () {
                mainPageProvider.pageindex = 1;
              },
            ),
            BottomAppBarWidget(
              icon: mainPageProvider.pageindex == 2
                  ? Ionicons.cart
                  : Ionicons.cart_outline,
              ontap: () {
                mainPageProvider.pageindex = 2;
              },
            ),
            BottomAppBarWidget(
              icon: mainPageProvider.pageindex == 3
                  ? Ionicons.person
                  : Ionicons.person_outline,
              ontap: () {
                mainPageProvider.pageindex = 3;
              },
            ),
          ]),
        ),
      ));
    });
  }
}
