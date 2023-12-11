import 'package:flutter/material.dart';

import '../dummy_data/companies.dart';
import '../dummy_data/filters.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drives_screen/drive_tile.dart';
import '../widgets/drives_screen/filter_builder.dart';
import '../widgets/drives_screen/filter_functions.dart';

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
      ),
      //TODO: Add function to mark drives (review for later-ish)
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
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            isDense: true,
                            label: const Text("Search for Drives"),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
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
