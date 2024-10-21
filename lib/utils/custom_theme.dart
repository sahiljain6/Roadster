import 'package:flutter/material.dart';


class CustomTheme {
  static const Color grey = Color(0xffDFDFDF);
  static const Color yellow = Color(0xffFFDB47);
  static var cardShadow = [
    BoxShadow(
      color: Colors.grey[400]!,
      blurRadius: 2,
      spreadRadius: .1,
      offset: const Offset(0, 4),
    ),

    // Shadow for bottom-right corner
  ];
  static const buttonShadow = [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(3, 3),
      blurRadius: 6,
      spreadRadius: .1,
    ),
  ];
  static const Color khaki = Color.fromARGB(255, 199, 175, 145);


  static cardDecor() {
    return BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(35),
        boxShadow: cardShadow);
  }

  static logInCardDecor() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(1),
            Colors.black.withOpacity(0),
          ]),
      borderRadius: BorderRadius.circular(35),
    );
  }
}
