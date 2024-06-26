import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import './themes/theme_manager.dart';
import 'bloc/details_blocs/contact_details_bloc.dart';
import 'bloc/details_blocs/intermediate_school_details_bloc.dart';
import 'bloc/details_blocs/metric_school_details_bloc.dart';
import 'bloc/details_blocs/personal_details_bloc.dart';
import 'bloc/details_blocs/undergraduate_details_bloc.dart';
import 'bloc/drive_bloc.dart';
import 'bloc/login_bloc.dart';
import 'bloc/register_bloc.dart';
import 'bloc/resume_bloc.dart';
import 'screens/login_screen.dart';

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
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      FlutterDisplayMode.setHighRefreshRate();
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<ContactDetailsBloc>(
            create: (context) => ContactDetailsBloc()),
        BlocProvider<PersonalDetailsBloc>(
            create: (context) => PersonalDetailsBloc()),
        BlocProvider<UndergraduateDetailsBloc>(
            create: (context) => UndergraduateDetailsBloc()),
        BlocProvider<MetricSchoolDetailsBloc>(
            create: (context) => MetricSchoolDetailsBloc()),
        BlocProvider<IntermediateSchoolDetailsBloc>(
            create: (context) => IntermediateSchoolDetailsBloc()),
        BlocProvider<DriveBloc>(create: (context) => DriveBloc()),
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
        BlocProvider<ResumeBloc>(create: (context) => ResumeBloc())
      ],
      child: MaterialApp(
        title: 'The College Placement Application',
        theme: ThemeManager.getTheme(
                themeMode: _themeMode,
                primaryColor: Colors.red.shade800,
                secondaryColor: Colors.blueAccent,
                tertiaryColor: const Color.fromARGB(255, 6, 184, 140))
            .copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          }),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
