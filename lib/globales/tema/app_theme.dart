import 'package:flutter/material.dart';


class AppTheme {
static const Color primary = Color(0xFFFB8C00); // deepOrange


static final ThemeData lightTheme = ThemeData(
useMaterial3: false,
primaryColor: primary,
colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(secondary: Colors.orangeAccent),
appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
elevatedButtonTheme: ElevatedButtonThemeData(
style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
),
);
}