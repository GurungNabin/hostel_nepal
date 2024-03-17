import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final int maxLines;
  late bool obText;

  PasswordTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.obText,
      this.maxLines = 1});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obText,
      style: const TextStyle(
          fontSize: 15, color: Colors.black54, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
            fontSize: 15, color: Colors.black54, fontWeight: FontWeight.normal),
        label: Text(widget.label),
        hintStyle: const TextStyle(
            fontSize: 15, color: Colors.black54, fontWeight: FontWeight.normal),
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
        suffixIcon: IconButton(
          icon: Icon(
            widget.obText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              widget.obText = !widget.obText;
            });
          },
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter Your ${widget.hintText}!!';
        }
        return null;
      },
    );
  }
}
