import 'package:flutter/material.dart';

String uri = 'https://www.collegesnepal.com/api';

class GlobalVariables {
  static final appBarGradient = LinearGradient(
    colors: [
      Colors.blue.withOpacity(0.8),
      GlobalVariables.mainColor,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const mainColor = Color.fromRGBO(254, 92, 52, 0.9);
  static const backColor = Color.fromRGBO(235, 235, 235, 1.0);
  static const categoryColor = Color.fromARGB(0, 242, 146, 0);
  static const backgroundColour = Color.fromRGBO(242, 244, 255, 1);
  static const eventListColor = Color.fromRGBO(0, 191, 225, 1);
  static const secondaryColor = Color.fromRGBO(255, 175, 68, 1);
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const myApplyNowButtonColor = Color.fromARGB(255, 239, 156, 4);
}
