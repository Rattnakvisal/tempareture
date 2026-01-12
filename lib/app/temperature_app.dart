import 'package:flutter/material.dart';
import '../screens/temperature_home_page.dart';
import '../theme/app_theme.dart';

class TemperatureApp extends StatelessWidget {
  const TemperatureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: AppTheme.dark(),
      home: const TemperatureHomePage(),
    );
  }
}
