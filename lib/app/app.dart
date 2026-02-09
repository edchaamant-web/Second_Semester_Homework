import 'package:excel_homework/core/string/app_string.dart';
import 'package:excel_homework/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../screens/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      title: AppString.appTitle(),
      theme: AppTheme.lightTheme,
      home: const MyHomePage(),
    );
  }
}
