import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
    textTheme: const TextTheme(bodyMedium: TextStyle(fontFamily: 'Poppins')),
  );
}
