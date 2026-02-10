import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_homework/core/string/app_string.dart';

import '../core/theme/app_theme.dart';
import '../features/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode myThemeMode = ThemeMode.light; // ✅ خارج build

  @override
  void initState() {
    super.initState();
    _loadTheme(); // تحميل الوضع عند بدء التطبيق
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDark') ?? false;
    setState(() {
      myThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (myThemeMode == ThemeMode.light) {
        myThemeMode = ThemeMode.dark;
        prefs.setBool('isDark', true);
      } else {
        myThemeMode = ThemeMode.light;
        prefs.setBool('isDark', false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: myThemeMode,
      home: HomePage(toggleTheme: toggleTheme), // تمرير الدالة
    );
  }
}
