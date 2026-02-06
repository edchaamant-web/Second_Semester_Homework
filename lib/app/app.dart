import 'package:flutter/material.dart';
import 'package:sql_homework/core/string/app_string.dart';

import '../core/theme/app_theme.dart';
import '../features/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle(),
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
