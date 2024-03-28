import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hitTxt,
    required this.obsTxt,
    this.icon,
    this.inputType,
    this.validator,
    this.myKey,
  });

  final TextEditingController controller;
  final String hitTxt;
  final bool obsTxt;
  final Widget? icon;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final Key? myKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: myKey,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: obsTxt,
      keyboardType: inputType,
      decoration: InputDecoration(
          suffixIcon: icon,
          suffixIconColor: Colors.grey.shade600,
          hintText: hitTxt,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: Colors.red, strokeAlign: 4, width: 2.5)),
          errorStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          errorMaxLines: 2,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)))),
    );
  }
}
