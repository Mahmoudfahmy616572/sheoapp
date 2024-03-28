// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    super.key,
    required this.icon,
    required this.ontap,
  });
  final IconData? icon;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
      child: GestureDetector(
          onTap: ontap,
          child: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }
}
