import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final int maxLines;
  final bool obText;
  final TextStyle? hintStyle;
  final bool? enabled;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.enabled,
    this.obText = false,
    this.maxLines = 1,
    this.hintStyle, // Provide a default value here if needed
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: obText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle, // Use hintStyle if provided
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter Your $hintText";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
