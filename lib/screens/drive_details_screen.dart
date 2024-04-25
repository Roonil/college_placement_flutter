import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/details_blocs/intermediate_school_details_bloc.dart';
import '../bloc/details_blocs/intermediate_school_details_events.dart';
import '../bloc/details_blocs/metric_school_details_bloc.dart';
import '../bloc/details_blocs/metric_school_details_events.dart';
import '../bloc/details_blocs/undergraduate_details_bloc.dart';
import '../bloc/details_blocs/undergraduate_details_events.dart';
import '../bloc/details_blocs/contact_details_bloc.dart';
import '../bloc/details_blocs/contact_details_events.dart';
import '../bloc/details_blocs/personal_details_bloc.dart';
import '../bloc/details_blocs/personal_details_events.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_bloc_states.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_details_screen/resume_tile.dart';
import '../widgets/drive_tile_name.dart';
import '../widgets/drive_details_screen/job_description_table.dart';
import './student_details_screen.dart';

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
                                FetchContactDetailsEvent(
                                    studentID:
                                        (BlocProvider.of<LoginBloc>(context)
                                                .state as LoggedInState)
                                            .student
                                            .id,
                                    token: (BlocProvider.of<LoginBloc>(context)
                                            .state as LoggedInState)
                                        .student
                                        .token));
                            BlocProvider.of<PersonalDetailsBloc>(context).add(
                                FetchPersonalDetailsEvent(
                                    studentID:
                                        (BlocProvider.of<LoginBloc>(context)
                                                .state as LoggedInState)
                                            .student
                                            .id,
                                    token: (BlocProvider.of<LoginBloc>(context)
                                            .state as LoggedInState)
                                        .student
                                        .token));
                            BlocProvider.of<UndergraduateDetailsBloc>(context)
                                .add(FetchUndergraduateDetailsEvent(
                                    studentID:
                                        (BlocProvider.of<LoginBloc>(context)
                                                .state as LoggedInState)
                                            .student
                                            .id,
                                    token: (BlocProvider.of<LoginBloc>(context)
                                            .state as LoggedInState)
                                        .student
                                        .token));
                            BlocProvider.of<MetricSchoolDetailsBloc>(context)
                                .add(FetchMetricSchoolDetailsEvent(
                                    studentID:
                                        (BlocProvider.of<LoginBloc>(context)
                                                .state as LoggedInState)
                                            .student
                                            .id,
                                    token: (BlocProvider.of<LoginBloc>(context)
                                            .state as LoggedInState)
                                        .student
                                        .token));
                            BlocProvider.of<IntermediateSchoolDetailsBloc>(
                                    context)
                                .add(FetchIntermediateSchoolDetailsEvent(
                                    studentID:
                                        (BlocProvider.of<LoginBloc>(context)
                                                .state as LoggedInState)
                                            .student
                                            .id,
                                    token: (BlocProvider.of<LoginBloc>(context)
                                            .state as LoggedInState)
                                        .student
                                        .token));
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
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(
                                left: 24, top: 4, bottom: 4, right: 10)),
                        onPressed: () {
                          // FilePickerResult? result = await FilePicker.platform
                          //     .pickFiles(
                          //         type: FileType.custom,
                          //         allowedExtensions: ['pdf']);
                          showModalBottomSheet(
                              elevation: 0,
                              useRootNavigator: true,
                              context: context,
                              builder: (context) => const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ResumeTile(name: "Resume1.pdf"),
                                        ResumeTile(name: "Resume2.pdf"),
                                        ResumeTile(name: "Resume3.pdf"),
                                      ],
                                    ),
                                  ));
                        },
                        child: const Row(
                          children: [
                            Text("Select Resume"),
                            Icon(
                              Icons.arrow_drop_down,
                            )
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.check_circle_outline_outlined,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Text("Resume1.pdf"),
                    ),
                    // const Icon(
                    //   Icons.cancel_outlined,
                    //   color: Colors.red,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 4.0),
                    //   child: Text("No Resume Selected!"),
                    // )
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
