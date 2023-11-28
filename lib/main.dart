import 'package:flutter/material.dart';

import './screens/drives_screen.dart';
import './themes/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.getTheme(
          themeMode: _themeMode,
          primaryColor:
              Colors.deepPurple, // const Color.fromARGB(255, 241, 84, 105),
          secondaryColor: const Color.fromARGB(255, 49, 49, 49),
          tertiaryColor: Colors.black),
      home: const DrivesScreen(),
    );
  }
}
