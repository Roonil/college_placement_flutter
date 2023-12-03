import 'package:flutter/material.dart';

import '../dummy_data/companies.dart';
import '../dummy_data/filters.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_tile.dart';
import '../widgets/filter_builder.dart';
import '../widgets/filter_functions.dart';

class DrivesScreen extends StatefulWidget {
  const DrivesScreen({
    super.key,
  });

  @override
  State<DrivesScreen> createState() => _DrivesScreenState();
}

class _DrivesScreenState extends State<DrivesScreen> {
  Set<Company> filteredCompanies = companies;

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
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text("Filter: "),
                  ),
                  //TODO: Add clear filters button
                  Expanded(
                    child: FilterBuilder(
                        filters: filters,
                        onTap: (filterType) {
                          setState(() {
                            filteredCompanies = FilterFunctions.applyFilters(
                                companies: companies, filterType: filterType);
                          });
                        }),
                  )
                ],
              ),
            ),
            filteredCompanies.isEmpty
                ? Text(
                    "No Drives Found!",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: filteredCompanies.length,
                      itemBuilder: (context, index) => DriveTile(
                          company: filteredCompanies.elementAt(index)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
