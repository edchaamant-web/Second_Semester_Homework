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

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: AppColor.primary()),
    ),

    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColor.backGround(),
        fontWeight: FontWeight.bold,
      ),

      labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),

      labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}
