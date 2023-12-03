import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import './screens/drives_screen.dart';
import './themes/theme_manager.dart';
import './bloc/contact_details_bloc.dart';
import './bloc/personal_details_bloc.dart';

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
    if (Platform.isAndroid || Platform.isIOS) {
      FlutterDisplayMode.setHighRefreshRate();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactDetailsBloc>(
          create: (context) => ContactDetailsBloc(),
        ),
        BlocProvider<PersonalDetailsBloc>(
          create: (context) => PersonalDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'The College Placement Application',
        theme: ThemeManager.getTheme(
            themeMode: _themeMode,
            primaryColor: Colors.deepPurple,
            secondaryColor: Colors.blueAccent,
            tertiaryColor: const Color.fromARGB(255, 6, 184, 140)),
        home: const DrivesScreen(),
      ),
    );
  }
}
