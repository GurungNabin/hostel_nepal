import 'package:flutter/material.dart';
import 'package:hostel_nepal/constants/dimensions.dart';




class LoaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final bool loader;

  const LoaderButton(
      {super.key,
        required this.text,
        required this.onTap,
        this.loader = true,
        this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loader ? onTap : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
      ),
      child: loader
          ? Text(
        text,
        style:  TextStyle(
          fontSize: Dimensions.font18,
        ),
      )
          : const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}