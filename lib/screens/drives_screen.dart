import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;

import '../bloc/drive_bloc.dart';
import '../bloc/drive_events.dart';
import '../bloc/drive_states.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_bloc_states.dart';
import '../bloc/login_events.dart';
import '../dummy_data/companies.dart';

import '../main.dart';
import '../models/company.dart';
import '../widgets/drives_screen/drive_tile.dart';

import '../widgets/drives_screen/filter_functions.dart';
import '../widgets/drives_screen/sort_and_filter.dart';

import 'login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final SortAndFilter sortAndFilter = SortAndFilter(
        onChanged: (value) => setState(() {
              FilterFunctions.showExpired = !FilterFunctions.showExpired;
            }),
        applyFilterCallBack: (filterType) {
          setState(() {
            previouslyFilteredCompanies = FilterFunctions.applyFilters(
                companies: companies, filterType: filterType);
            filteredCompanies = FilterFunctions.searchCompanies(
                searchString: searchController.text.trim().toLowerCase(),
                companies: previouslyFilteredCompanies);
          });
        },
        criterias: {
          "Name": (value) => setState(() {
                (value)
                    ? filteredCompanies = FilterFunctions.sortCompanies(
                        companies: previouslyFilteredCompanies,
                        sortCriteria: "Name")
                    : null;
              }),
          "Registrations": (value) => setState(() {
                (value)
                    ? filteredCompanies = FilterFunctions.sortCompanies(
                        companies: previouslyFilteredCompanies,
                        sortCriteria: "Registrations")
                    : null;
              }),
          "Date of Drive": (value) => setState(() {
                (value)
                    ? filteredCompanies = FilterFunctions.sortCompanies(
                        companies: previouslyFilteredCompanies,
                        sortCriteria: "Date of Drive")
                    : null;
              }),
          "Time Left": (value) => setState(() {
                (value)
                    ? filteredCompanies = FilterFunctions.sortCompanies(
                        companies: previouslyFilteredCompanies,
                        sortCriteria: "Time Left")
                    : null;
              }),
          "Date of Creation": (value) => setState(() {
                (value)
                    ? filteredCompanies = FilterFunctions.sortCompanies(
                        companies: previouslyFilteredCompanies,
                        sortCriteria: "Date of Creation")
                    : null;
              })
        });

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
                current is DrivesFetchFailedState) ||
            (current is FetchingDrivesState),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ongoing Drives"),
              actions: [
                IconButton(
                    tooltip: "Logout",
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(const LogoutEvent());
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    icon: const Icon(Icons.logout)),
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
            endDrawer: !Platform.isAndroid && !Platform.isIOS
                ? Drawer(child: sortAndFilter)
                : null,
            body: Builder(builder: (context) {
              // print(filteredCompanies.first.name);
              // print(filteredCompanies
              //     .where((company) => company.timeLeft < 0)
              //     .toSet()
              //     .first
              //     .name);

              return Padding(
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
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, right: 8),
                              child: TextFormField(
                                enabled: state is! FetchingDrivesState,
                                controller: searchController,
                                onFieldSubmitted: (value) => setState(() {
                                  filteredCompanies =
                                      FilterFunctions.searchCompanies(
                                          companies:
                                              previouslyFilteredCompanies,
                                          searchString:
                                              value.trim().toLowerCase());
                                }),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      tooltip: "Search",
                                      onPressed: state is FetchingDrivesState
                                          ? null
                                          : () {
                                              setState(() {
                                                filteredCompanies = FilterFunctions
                                                    .searchCompanies(
                                                        companies:
                                                            previouslyFilteredCompanies,
                                                        searchString:
                                                            searchController
                                                                .text
                                                                .trim()
                                                                .toLowerCase());
                                              });
                                            },
                                    ),
                                    isDense: true,
                                    label: const Text("Search for Drives"),
                                    contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                          ),
                          searchController.text.trim().isEmpty
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: state is FetchingDrivesState
                                        ? null
                                        : () {
                                            setState(() {
                                              searchController.text = "";
                                              filteredCompanies = FilterFunctions
                                                  .searchCompanies(
                                                      companies:
                                                          previouslyFilteredCompanies,
                                                      searchString:
                                                          searchController.text
                                                              .trim()
                                                              .toLowerCase());
                                            });
                                          },
                                    icon: const Icon(
                                      Icons.clear,
                                    ),
                                    tooltip: "Clear Search Results",
                                  )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: state is FetchingDrivesState
                                  ? null
                                  : () {
                                      BlocProvider.of<DriveBloc>(context).add(
                                          FetchDrivesEvent(
                                              driveID: null,
                                              studentID: (BlocProvider.of<
                                                          LoginBloc>(context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                              token: (BlocProvider.of<
                                                          LoginBloc>(context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .token));
                                    },
                              icon: const Icon(
                                Icons.refresh,
                              ),
                              tooltip: "Refresh Drives",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: state is FetchingDrivesState
                                  ? null
                                  : () => Platform.isAndroid || Platform.isIOS
                                      ? showModalBottomSheet(
                                          useRootNavigator: true,
                                          context: context,
                                          builder: (context) => sortAndFilter)
                                      : Scaffold.of(context).openEndDrawer(),
                              icon: Icon(
                                Icons.filter_list_rounded,
                                color: FilterFunctions.appliedFilters.isNotEmpty
                                    ? Theme.of(context).colorScheme.tertiary
                                    : null,
                              ),
                              tooltip: "Filters",
                            ),
                          )
                        ],
                      ),
                    ),
                    state is FetchingDrivesState
                        ? const Center(child: CircularProgressIndicator())
                        : filteredCompanies.isEmpty ||
                                (!FilterFunctions.showExpired &&
                                    filteredCompanies.every(
                                        (company) => company.timeLeft < 0))
                            ? Text(
                                "No Drives Found!",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            : Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) =>
                                      !FilterFunctions.showExpired &&
                                              filteredCompanies
                                                      .elementAt(index)
                                                      .timeLeft <
                                                  0
                                          ? Container()
                                          : const SizedBox(
                                              height: 20,
                                            ),
                                  itemCount: filteredCompanies.length,
                                  itemBuilder: (context, index) =>
                                      !FilterFunctions.showExpired &&
                                              filteredCompanies
                                                      .elementAt(index)
                                                      .timeLeft <
                                                  0
                                          ? Container()
                                          : DriveTile(
                                              company: filteredCompanies
                                                  .elementAt(index)),
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
