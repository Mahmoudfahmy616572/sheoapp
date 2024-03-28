import 'package:flutter/material.dart';
import 'package:sheoapp/views/shared/app_style.dart';

class CategoryBTN extends StatelessWidget {
  const CategoryBTN({
    super.key,
    required this.btnClr,
    required this.txt,
  });
  final String txt;
  final Color btnClr;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 45,
        width: MediaQuery.of(context).size.width * 0.23,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border:
                Border.all(color: btnClr, width: 1, style: BorderStyle.solid)),
        child: Center(
          child: Text(
            txt,
            style: appstyle(20, btnClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
