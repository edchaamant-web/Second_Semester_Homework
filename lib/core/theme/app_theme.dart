import 'package:flutter/material.dart';

import '../color/app_color.dart';

class AppTheme {
  AppTheme._(); // private constructor

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColor.primary(),
    useMaterial3: true,

    scaffoldBackgroundColor: AppColor.backGround(),

    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.primary(),
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.primary(), width: 2),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColor.lightPrimary(), width: 2),
      ),
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColor.backGround(),
        fontWeight: FontWeight.bold,
      ),

      labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

      labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

      labelSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
    ),
  );
  // -------------------- Dark Theme --------------------
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.darkPrimary(),
    scaffoldBackgroundColor: AppColor.darkBackGround(),
    cardColor: Color.fromARGB(255, 55, 55, 58), // ✅ لون الكارد
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColor.darkPrimary(),
      titleTextStyle: TextStyle(
        color: AppColor.darkText(),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColor.darkText()),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.darkPrimary()),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.darkLightPrimary(), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: AppColor.darkPrimary(), width: 2),
      ),
      hintStyle: TextStyle(color: AppColor.darkSubText()),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColor.darkText(),
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColor.darkText(),
      ),
      labelLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColor.darkText(),
      ),
      bodyMedium: TextStyle(color: AppColor.darkText()),
    ),
    iconTheme: IconThemeData(color: AppColor.darkText()),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.darkPrimary(),
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
