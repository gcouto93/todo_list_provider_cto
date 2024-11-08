import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class  TodoListUiConfig {
  TodoListUiConfig._();

  static get theme => ThemeData(
    textTheme: GoogleFonts.mandaliTextTheme(),
    primaryColor: const Color(0xff5C77CE),
    primaryColorLight: const Color(0xffABC8F7),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        iconColor: const Color(0xff5C77CE)
      ),
    )

  );
}