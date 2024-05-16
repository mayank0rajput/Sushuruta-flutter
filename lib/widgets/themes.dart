import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: primaryGreen)
  );

  // static ThemeData darkTheme(BuildContext context) => ThemeData(
  //   brightness: Brightness.dark,
  // );

  //Colors
  static Color primaryGreen = Color(0xff53B175);
  static Color creamColor = Color(0xfff5f5f5);
  static Color primaryGrey = Color(0xff7c7c7c);
  static Color black = Color(0xff181725);
  static Color borderGrey = Color(0xffe2e2e2);
  // static Color darkBluishColor = Color(0xff403b58);
}