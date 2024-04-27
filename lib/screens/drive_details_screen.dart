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
import '../bloc/resume_bloc.dart';
import '../bloc/resume_states.dart';
import '../main.dart';
import '../models/company.dart';
import '../widgets/drive_details_screen/resume_tile.dart';
import '../widgets/drive_tile_name.dart';
import '../widgets/drive_details_screen/job_description_table.dart';
import '../widgets/roles_chip_builder.dart';
import './student_details_screen.dart';

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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.company.name),
              actions: [
                IconButton(
                    onPressed: () => Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? MyApp.of(context).changeTheme(ThemeMode.light)
                        : MyApp.of(context).changeTheme(ThemeMode.dark),
                    icon: Icon(
                      Theme.of(context).colorScheme.brightness ==
                              Brightness.dark
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
                      companyID: widget.company.companyID.toString(),
                      imageURL: widget.company.imageURL),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("${widget.company.startedAtTime} ago"),
                  ),
                  Row(
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
                                  BlocProvider.of<ContactDetailsBloc>(context)
                                      .add(FetchContactDetailsEvent(
                                          studentID:
                                              (BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                          token: (BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .state as LoggedInState)
                                              .student
                                              .token));
                                  BlocProvider.of<PersonalDetailsBloc>(context)
                                      .add(FetchPersonalDetailsEvent(
                                          studentID:
                                              (BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                          token: (BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .state as LoggedInState)
                                              .student
                                              .token));
                                  BlocProvider.of<
                                          UndergraduateDetailsBloc>(context)
                                      .add(FetchUndergraduateDetailsEvent(
                                          studentID:
                                              (BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                          token: (BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .state as LoggedInState)
                                              .student
                                              .token));
                                  BlocProvider.of<
                                          MetricSchoolDetailsBloc>(context)
                                      .add(FetchMetricSchoolDetailsEvent(
                                          studentID:
                                              (BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                          token: (BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .state as LoggedInState)
                                              .student
                                              .token));
                                  BlocProvider.of<
                                              IntermediateSchoolDetailsBloc>(
                                          context)
                                      .add(FetchIntermediateSchoolDetailsEvent(
                                          studentID:
                                              (BlocProvider.of<LoginBloc>(
                                                          context)
                                                      .state as LoggedInState)
                                                  .student
                                                  .id,
                                          token: (BlocProvider.of<LoginBloc>(
                                                      context)
                                                  .state as LoggedInState)
                                              .student
                                              .token));
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => StudentDetailsScreen(
                                      driveName: widget.company.name,
                                      selectedRole:
                                          widget.company.roles[selectedRoleIdx],
                                      selectedResumeIdx: groupValue,
                                      driveID: widget.company.companyID,
                                    ),
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
                                showModalBottomSheet(
                                    elevation: 0,
                                    useRootNavigator: true,
                                    context: context,
                                    builder: (context) => ResumePicker(
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
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(),
                                )
                              : Row(
                                  children: ((state is UpdatedResumeState &&
                                              state
                                                  .resumes['resume_$groupValue']
                                                  .toString()
                                                  .isNotEmpty) ||
                                          (state is FetchedResumesState &&
                                              state
                                                  .resumes['resume_$groupValue']
                                                  .toString()
                                                  .isNotEmpty))
                                      ? [
                                          Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child:
                                                Text("Resume$groupValue.pdf"),
                                          ),
                                        ]
                                      : [
                                          const Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text("No Resume Selected!"),
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

class ResumePicker extends StatefulWidget {
  final int groupValue;
  final Function(int) onChanged;

  const ResumePicker(
      {super.key, required this.groupValue, required this.onChanged});

  @override
  State<ResumePicker> createState() => _ResumePickerState();
}

class _ResumePickerState extends State<ResumePicker> {
  int? groupValue;
  final Map<String, dynamic> resumes = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {
          state is FetchedResumesState
              ? resumes.addAll(state.resumes)
              : state is UpdatedResumeState
                  ? resumes.addAll(state.resumes)
                  : null;
        },
        listenWhen: (previous, current) =>
            (previous is FetchingResumesState &&
                current is FetchedResumesState) ||
            (previous is UpdatingResumeState && current is UpdatedResumeState),
        buildWhen: (previous, current) =>
            (previous is FetchingResumesState &&
                current is FetchedResumesState) ||
            (previous is UpdatingResumeState && current is UpdatedResumeState),
        builder: (context, state) {
          state is FetchedResumesState
              ? resumes.addAll(state.resumes)
              : state is UpdatedResumeState
                  ? resumes.addAll(state.resumes)
                  : null;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeTile(
                    name: resumes['resume_1'] != null ? "Resume1.pdf" : null,
                    currentValue: 1,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 1;
                          widget.onChanged(value ?? 1);
                        })),
                ResumeTile(
                    name: resumes['resume_2'] != null ? "Resume2.pdf" : null,
                    currentValue: 2,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 2;
                          widget.onChanged(value ?? 2);
                        })),
                ResumeTile(
                    name: resumes['resume_3'] != null ? "Resume3.pdf" : null,
                    currentValue: 3,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 3;
                          widget.onChanged(value ?? 3);
                        })),
              ],
            ),
          );
        });
  }
}
