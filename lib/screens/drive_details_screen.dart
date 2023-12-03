import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contact_details_bloc.dart';
import '../bloc/contact_details_events.dart';
import '../bloc/personal_details_bloc.dart';
import '../bloc/personal_details_events.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_tile_name.dart';
import '../widgets/job_description_table.dart';
import 'student_details_screen.dart';

class DriveDetailsScreen extends StatefulWidget {
  final Company company;
  const DriveDetailsScreen({super.key, required this.company});

  @override
  State<DriveDetailsScreen> createState() => _DriveDetailsScreenState();
}

class _DriveDetailsScreenState extends State<DriveDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DriveTileName(
                companyName: widget.company.name,
                driveType: widget.company.driveType,
                companyID: widget.company.companyID,
                imageURL: widget.company.imageURL),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${widget.company.startedAtTime} ago"),
            ),
            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ContactDetailsBloc>(context).add(
                                const FetchContactDetailsEvent(studentID: "1"));
                            BlocProvider.of<PersonalDetailsBloc>(context).add(
                                const FetchPersonalDetailsEvent(
                                    studentID: "1"));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const StudentDetailsScreen(),
                            ));
                          },
                          child: const Text("Apply")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Resume")),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Job Description",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: JobDescriptionTable(
                        company: widget.company,
                      ),
                    ),
                    Text(
                      "About the Drive",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.company.details,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
