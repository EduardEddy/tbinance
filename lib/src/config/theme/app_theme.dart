import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        colorSchemeSeed: const Color(
          0xff2862f5,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeData().primaryColor,
          centerTitle: true,
          elevation: 5,
          shadowColor: const Color(0xFF022B3A),
        ),
      );
}
