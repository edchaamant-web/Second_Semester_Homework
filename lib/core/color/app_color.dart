import 'package:flutter/material.dart';

class AppColor {
  static Color primary() {
    return Color(0xFF673AB7);
  }

  static Color lightPrimary() {
    return Color.fromARGB(255, 177, 152, 221);
  }

  static Color backGround() {
    return Color(0xFFFFFFFF);
  }

  static Color delet() {
    return Color.fromRGBO(244, 67, 54, 1);
  }

  // ألوان الثيم الليلي
  static Color darkPrimary() {
    return Color(0xFF9575CD); // نسخة فاتحة قليلاً من الأرجواني
  }

  static Color darkLightPrimary() {
    return Color(0xFFB39DDB); // نسخة فاتحة من primary
  }

  static Color darkBackGround() {
    return Color(0xFF121212); // أسود قاتم مناسب للدارك مود
  }

  static Color darkDelet() {
    return Color.fromRGBO(244, 67, 54, 1); // نفس الأحمر لأنه واضح على دارك
  }

  static Color darkText() {
    return Color(0xFFFFFFFF); // نص أبيض على الخلفية الداكنة
  }

  static Color darkSubText() {
    return Color(0xFFB0B0B0); // نص فرعي رمادي فاتح
  }
}
