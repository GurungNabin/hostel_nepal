import 'package:flutter/material.dart';



void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.white,),
      ),
    ),
  );
}