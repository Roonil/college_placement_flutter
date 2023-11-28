import 'package:flutter/material.dart';

import '../dummy_data/companies.dart';
import '../main.dart';
import '../widgets/drive_tile.dart';

class DrivesScreen extends StatefulWidget {
  const DrivesScreen({
    super.key,
  });

  @override
  State<DrivesScreen> createState() => _DrivesScreenState();
}

class _DrivesScreenState extends State<DrivesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ongoing Drives"),
        actions: [
          IconButton(
              onPressed: () =>
                  Theme.of(context).colorScheme.brightness == Brightness.dark
                      ? MyApp.of(context).changeTheme(ThemeMode.light)
                      : MyApp.of(context).changeTheme(ThemeMode.dark),
              icon: Icon(
                Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? Icons.wb_sunny_rounded
                    : Icons.nightlight_round,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ))
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) =>
              DriveTile(company: companies.elementAt(index)),
        ),
      ),
    );
  }
}
