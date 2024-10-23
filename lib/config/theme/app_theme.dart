import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.loraTextTheme(),
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.cyan.shade800),
    titleTextStyle: GoogleFonts.lora(fontSize: 30, fontWeight: FontWeight.w500),
    // TextStyle(color: Colors.cyan.shade800, fontSize: 25)
  );
}
