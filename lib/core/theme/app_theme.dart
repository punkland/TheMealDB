import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color black1 = const Color(0xFF282828);
  static Color orange = const Color(0xFFF8682C);

  static TextStyle text12W200White = TextStyle(
      color: white,
      fontWeight: FontWeight.w700,
      fontSize: 25,
      fontFamily: 'Montserrat');

  static TextStyle text14W400Black = TextStyle(
      color: black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      fontFamily: 'Montserrat');

  static TextStyle text18600Pop = TextStyle(
    color: black1,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'Poppins',
  );
  static TextStyle text16500Pop = TextStyle(
    color: black1,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: 'Poppins',
  );

  static TextStyle text16w600Mon = TextStyle(
    color: black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: 'Montserrat',
  );
  static TextStyle text16Mon = TextStyle(
    color: black,
    fontSize: 16,
    fontFamily: 'Montserrat',
  );

  static TextStyle text18w600Mont = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'Montserrat',
  );
}
