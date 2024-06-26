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
import '../bloc/login_events.dart';
import '../bloc/resume_bloc.dart';
import '../bloc/resume_states.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_details_screen/resume_picker.dart';

import '../widgets/drive_tile_name.dart';
import '../widgets/drive_details_screen/job_description_table.dart';
import '../widgets/roles_chip_builder.dart';
import './student_details_screen.dart';
import 'login_screen.dart';

class DriveDetailsScreen extends StatefulWidget {
  final Company company;
  const DriveDetailsScreen({super.key, required this.company});

  @override
  State<DriveDetailsScreen> createState() => _DriveDetailsScreenState();
}

class _DriveDetailsScreenState extends State<DriveDetailsScreen> {
  int groupValue = 1;
  int selectedRoleIdx = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {
          (state is ResumeUpdateFailedState || state is ResumesFetchFailedState)
              ? {
                  ScaffoldMessenger.of(context).clearSnackBars(),
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.authError.toString().split(": ")[1])))
                }
              : null;
        },
        listenWhen: (previous, current) =>
            (previous is FetchingResumesState &&
                current is ResumesFetchFailedState) ||
            (previous is UpdatingResumeState &&
                current is ResumeUpdateFailedState),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.company.name),
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: DriveTileName(
                            companyName: widget.company.name,
                            driveType: widget.company.driveType,
                            companyID: widget.company.companyID.toString(),
                            imageURL: widget.company.imageURL),
                      ),
                      widget.company.hasRegistered ||
                              widget.company.timeLeft < 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  onPressed: !((state is UpdatedResumeState &&
                                              ((state.resumes[
                                                          'resume$groupValue'] !=
                                                      null) &&
                                                  state.resumes[
                                                          'resume$groupValue']
                                                      .toString()
                                                      .isNotEmpty)) ||
                                          (state is FetchedResumesState &&
                                              ((state.resumes[
                                                          'resume$groupValue'] !=
                                                      null) &&
                                                  state.resumes[
                                                          'resume$groupValue']
                                                      .toString()
                                                      .isNotEmpty)))
                                      ? null
                                      : () {
                                          BlocProvider.of<ContactDetailsBloc>(
                                                  context)
                                              .add(FetchContactDetailsEvent(
                                                  studentID: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .id,
                                                  token: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .token));
                                          BlocProvider.of<
                                                  PersonalDetailsBloc>(context)
                                              .add(FetchPersonalDetailsEvent(
                                                  studentID: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .id,
                                                  token: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .token));
                                          BlocProvider.of<
                                                      UndergraduateDetailsBloc>(
                                                  context)
                                              .add(FetchUndergraduateDetailsEvent(
                                                  studentID: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .id,
                                                  token: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .token));
                                          BlocProvider.of<
                                                      MetricSchoolDetailsBloc>(
                                                  context)
                                              .add(FetchMetricSchoolDetailsEvent(
                                                  studentID: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .id,
                                                  token: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .token));
                                          BlocProvider.of<
                                                      IntermediateSchoolDetailsBloc>(
                                                  context)
                                              .add(FetchIntermediateSchoolDetailsEvent(
                                                  studentID: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .id,
                                                  token: (BlocProvider.of<
                                                                      LoginBloc>(
                                                                  context)
                                                              .state
                                                          as LoggedInState)
                                                      .student
                                                      .token));
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                StudentDetailsScreen(
                                              driveName: widget.company.name,
                                              selectedRole: widget.company
                                                  .roles[selectedRoleIdx],
                                              selectedResumeIdx: groupValue,
                                              driveID: widget.company.companyID,
                                            ),
                                          ));
                                        },
                                  child: const Text("Apply")),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("${widget.company.startedAtTime}d ago"),
                  ),
                  widget.company.hasRegistered || widget.company.timeLeft < 0
                      ? Container()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Text("Applying for:"),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2),
                                    child: RolesChipBuilder(
                                        onTap: (index) => setState(() {
                                              selectedRoleIdx = index;
                                            }),
                                        roles: widget.company.roles,
                                        selectedIdx: selectedRoleIdx),
                                  )),
                            )
                          ],
                        ),
                  widget.company.hasRegistered
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "You have been registered in the drive",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                          ),
                        )
                      : widget.company.timeLeft < 0
                          ? Container()
                          : SingleChildScrollView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.only(
                                                left: 24,
                                                top: 4,
                                                bottom: 4,
                                                right: 10)),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              elevation: 0,
                                              useRootNavigator: true,
                                              context: context,
                                              builder: (context) =>
                                                  ResumePicker(
                                                    groupValue: groupValue,
                                                    onChanged: (value) => {
                                                      setState(() {
                                                        groupValue = value;
                                                      })
                                                    },
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
                                    (state is UpdatingResumeState ||
                                            state is FetchingResumesState)
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(),
                                          )
                                        : Row(
                                            children: ((state
                                                            is UpdatedResumeState &&
                                                        ((state.resumes[
                                                                    'resume$groupValue'] !=
                                                                null) &&
                                                            state.resumes[
                                                                    'resume$groupValue']
                                                                .toString()
                                                                .isNotEmpty)) ||
                                                    (state
                                                            is FetchedResumesState &&
                                                        (state.resumes[
                                                                'resume$groupValue'] !=
                                                            null) &&
                                                        (state.resumes[
                                                                'resume$groupValue']
                                                            .toString()
                                                            .isNotEmpty)))
                                                ? [
                                                    Icon(
                                                      Icons
                                                          .check_circle_outline_outlined,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                          "Resume$groupValue.pdf"),
                                                    ),
                                                  ]
                                                : [
                                                    const Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.red,
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4.0),
                                                      child: Text(
                                                          "No Resume Selected!"),
                                                    )
                                                  ])
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
        });
  }
}
