import 'package:flutter/material.dart';

import '../dummy_data/companies.dart';
import '../dummy_data/filter_actions.dart';
import '../dummy_data/filters.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_tile.dart';
import '../widgets/filter_builder.dart';

class DrivesScreen extends StatefulWidget {
  const DrivesScreen({
    super.key,
  });

  @override
  State<DrivesScreen> createState() => _DrivesScreenState();
}

final Set<FilterType> appliedFilters = {};

//TODO: For applying filter, create a function here that has list of companies as argument. Then replace current drives list with the argument
//TODO: For more than one filters, get list of filters, see which are applied then add them accordingly
class _DrivesScreenState extends State<DrivesScreen> {
  Set<Company> filteredCompanies = companies;

  Set<Company> applySingleFilter(
      {required Set<Company> initialCompanies,
      required FilterType filterType}) {
    switch (filterType) {
      case FilterType.registeredForDrive:
        return initialCompanies
            .where((company) => company.hasRegistered)
            .toSet();
      case FilterType.unregisteredForDrive:
        return initialCompanies
            .where((company) => !company.hasRegistered)
            .toSet();
      case FilterType.clearRegisterType:
        return initialCompanies;

      case FilterType.onlineDriveType:
        return initialCompanies
            .where((company) =>
                company.driveType == "Online" ||
                company.driveType == "Online/On Campus")
            .toSet();
      case FilterType.offlineDriveType:
        return initialCompanies
            .where((company) =>
                company.driveType == "On Campus" ||
                company.driveType == "Online/On Campus")
            .toSet();
      case FilterType.hybridDriveType:
        return initialCompanies
            .where((company) => company.driveType == "Online/On Campus")
            .toSet();
      case FilterType.clearDriveType:
        return initialCompanies;
      default:
        return initialCompanies;
    }
  }

  void applyFilter({required FilterType filterType}) {
    if (appliedFilters.contains(filterType)) return;
    {
      Set<Company> newlyFilteredCompanies = companies;

      switch (filterType) {
        case FilterType.unregisteredForDrive:
          appliedFilters.remove(FilterType.registeredForDrive);
          break;

        case FilterType.registeredForDrive:
          appliedFilters.remove(FilterType.unregisteredForDrive);
          break;

        case FilterType.clearRegisterType:
          appliedFilters.remove(FilterType.registeredForDrive);
          appliedFilters.remove(FilterType.unregisteredForDrive);
          break;

        case FilterType.onlineDriveType:
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;
        case FilterType.offlineDriveType:
          appliedFilters.remove(FilterType.onlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;
        case FilterType.hybridDriveType:
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.onlineDriveType);
          break;
        case FilterType.clearDriveType:
          appliedFilters.remove(FilterType.onlineDriveType);
          appliedFilters.remove(FilterType.offlineDriveType);
          appliedFilters.remove(FilterType.hybridDriveType);
          break;
        default:
          break;
      }

      filterType != FilterType.clearRegisterType &&
              filterType != FilterType.clearDriveType
          ? appliedFilters.add(filterType)
          : null;

      appliedFilters.isEmpty ? newlyFilteredCompanies.addAll(companies) : null;
      for (FilterType appliedFilter in appliedFilters) {
        newlyFilteredCompanies = applySingleFilter(
            initialCompanies: newlyFilteredCompanies,
            filterType: appliedFilter);
      }

      setState(() {
        filteredCompanies = newlyFilteredCompanies;
      });
    }
  }

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Filter: "),
                  //TODO: Add clear filters button
                  Expanded(
                    child: FilterBuilder(
                      filters: filters,
                      onTap: (registerType) =>
                          applyFilter(filterType: registerType),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: filteredCompanies.length,
                itemBuilder: (context, index) =>
                    DriveTile(company: filteredCompanies.elementAt(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
