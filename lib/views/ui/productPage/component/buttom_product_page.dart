import 'package:flutter/material.dart';

import '../../../shared/app_style.dart';

class ButtomProductPage extends StatelessWidget {
  const ButtomProductPage({
    super.key,
    this.ontap,
    required this.lable,
  });
  final void Function()? ontap;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          lable,
          style: appstyle(22, Colors.white, FontWeight.bold),
        )),
      ),
    ));
  }
}
