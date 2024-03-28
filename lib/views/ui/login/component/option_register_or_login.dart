import 'package:flutter/material.dart';

import '../../../shared/app_style.dart';

class OptionRegisterOrLogin extends StatelessWidget {
  const OptionRegisterOrLogin({
    super.key,
    this.onprss,
    required this.txt,
  });
  final void Function()? onprss;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onprss,
          child: Row(
            children: [
              Text(
                txt,
                style: appstyle(18, Colors.white, FontWeight.w700),
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 25,
              )
            ],
          ),
        ),
      ],
    );
  }
}
