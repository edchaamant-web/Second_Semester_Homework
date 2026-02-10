import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sql_homework/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      saveLocale: true,
      child: MyApp(),
    ),
  );
}
