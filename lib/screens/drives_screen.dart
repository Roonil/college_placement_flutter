import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

import '../bloc/drive_bloc.dart';
import '../bloc/drive_states.dart';
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
  Set<Company> previouslyFilteredCompanies = companies;
  final TextEditingController searchController = TextEditingController();

  Set<Company> searchCompanies(
      {required Set<Company> companies, required String searchString}) {
    final Set<Company> searchedCompanies = {};
    for (Company company in companies) {
      if (company.name.toLowerCase().contains(searchString.toLowerCase())) {
        searchedCompanies.add(company);
      }
    }

    return searchedCompanies;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriveBloc, DriveState>(
        listenWhen: (previous, current) =>
            previous is FetchingDrivesState &&
            current is DrivesFetchFailedState,
        listener: (context, state) {
          (state is DrivesFetchFailedState)
              ? {
                  ScaffoldMessenger.of(context).clearSnackBars(),
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.authError.toString().split(": ")[1])))
                }
              : null;
        },
        buildWhen: (previous, current) =>
            (previous is FetchingDrivesState &&
                current is FetchedDrivesState) ||
            (previous is FetchingDrivesState &&
                current is DrivesFetchFailedState),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ongoing Drives"),
              actions: [
                IconButton(
                  onPressed: () => Theme.of(context).colorScheme.brightness ==
                          Brightness.dark
                      ? MyApp.of(context).changeTheme(ThemeMode.light)
                      : MyApp.of(context).changeTheme(ThemeMode.dark),
                  icon: Icon(
                    Theme.of(context).colorScheme.brightness == Brightness.dark
                        ? Icons.wb_sunny_rounded
                        : Icons.nightlight_round,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  tooltip: "Change Theme",
                )
              ],
            ),
            //TODO: Add function to mark drives (review for later-ish)
            endDrawer: !Platform.isAndroid && !Platform.isIOS
                ? Drawer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterBuilder(
                          filters: filters,
                          applyFilterCallBack: (filterType) {
                            setState(() {
                              previouslyFilteredCompanies =
                                  FilterFunctions.applyFilters(
                                      companies: companies,
                                      filterType: filterType);

                              filteredCompanies = searchCompanies(
                                  searchString: searchController.text
                                      .trim()
                                      .toLowerCase(),
                                  companies: previouslyFilteredCompanies);
                            });
                          }),
                    ),
                  )
                : null,

            body: state is FetchingDrivesState
                ? const Center(child: CircularProgressIndicator())
                : Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, right: 8),
                                    //TODO: Add criteria using which to search (eg name, description, roles etc (FFBE))
                                    child: TextFormField(
                                      controller: searchController,
                                      onFieldSubmitted: (value) => setState(() {
                                        filteredCompanies = searchCompanies(
                                            companies:
                                                previouslyFilteredCompanies,
                                            searchString:
                                                value.trim().toLowerCase());
                                      }),
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: const Icon(Icons.search),
                                            tooltip: "Search",
                                            onPressed: () {
                                              setState(() {
                                                filteredCompanies = searchCompanies(
                                                    companies:
                                                        previouslyFilteredCompanies,
                                                    searchString:
                                                        searchController.text
                                                            .trim()
                                                            .toLowerCase());
                                              });
                                            },
                                          ),
                                          isDense: true,
                                          label:
                                              const Text("Search for Drives"),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () => Platform.isAndroid ||
                                            Platform.isIOS
                                        ? showModalBottomSheet(
                                            useRootNavigator: true,
                                            context: context,
                                            builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FilterBuilder(
                                                  filters: filters,
                                                  applyFilterCallBack:
                                                      (filterType) {
                                                    setState(() {
                                                      previouslyFilteredCompanies =
                                                          FilterFunctions
                                                              .applyFilters(
                                                                  companies:
                                                                      companies,
                                                                  filterType:
                                                                      filterType);

                                                      filteredCompanies = searchCompanies(
                                                          searchString:
                                                              searchController
                                                                  .text
                                                                  .trim()
                                                                  .toLowerCase(),
                                                          companies:
                                                              previouslyFilteredCompanies);
                                                    });
                                                  }),
                                            ),
                                          )
                                        : Scaffold.of(context).openEndDrawer(),
                                    icon: Icon(
                                      Icons.filter_list_rounded,
                                      color: FilterFunctions
                                              .appliedFilters.isNotEmpty
                                          ? Theme.of(context)
                                              .colorScheme
                                              .tertiary
                                          : null,
                                    ),
                                    tooltip: "Filters",
                                  ),
                                )
                                //TODO: Add clear filters button
                              ],
                            ),
                          ),
                          filteredCompanies.isEmpty
                              ? Text(
                                  "No Drives Found!",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )
                              : Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 20,
                                    ),
                                    itemCount: filteredCompanies.length,
                                    itemBuilder: (context, index) => DriveTile(
                                        company:
                                            filteredCompanies.elementAt(index)),
                                  ),
                                ),
                        ],
                      ),
                    );
                  }),
          );
        });
  }
}
