import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/drive_bloc.dart';
import '../bloc/drive_events.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_bloc_states.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_events.dart';
import '../bloc/register_states.dart';
import '../widgets/student_details_screen/intermediate_school_details/intermediate_school_details_card.dart';
import '../widgets/student_details_screen/metric_school_details/metric_school_details_card.dart';
import '../widgets/student_details_screen/undergraduate_details/undergraduate_details_card.dart';
import '../widgets/student_details_screen/contact_details/contact_details_card.dart';
import '../widgets/student_details_screen/personal_details/personal_details_card.dart';

class StudentDetailsScreen extends StatefulWidget {
  final int selectedResumeIdx, driveID;
  final String selectedRole, driveName;
  const StudentDetailsScreen(
      {super.key,
      required this.selectedRole,
      required this.driveID,
      required this.driveName,
      required this.selectedResumeIdx});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final TextEditingController dateOfBirthController = TextEditingController();
  final ExpansionTileController personalDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController contactDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController undergraduateDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController metricSchoolDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController
      intermediateSchoolDetailsExpansionTileController =
      ExpansionTileController();

  bool personalDetailsEdited = false,
      contactDetailsEdited = false,
      undergraduateDetailsEdited = false,
      intermediateDetailsEdited = false,
      matricDetailsEdited = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) =>
            (previous is RegisteringDriveState &&
                current is RegisteredDriveState) ||
            (previous is RegisteringDriveState &&
                current is DriveRegisterFailedState),
        listener: (context, state) {
          if (state is DriveRegisterFailedState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.authError.toString().split(": ")[1])));
          } else if (state is RegisteredDriveState) {
            BlocProvider.of<DriveBloc>(context).add(FetchDrivesEvent(
                driveID: null,
                token:
                    (BlocProvider.of<LoginBloc>(context).state as LoggedInState)
                        .student
                        .token,
                studentID:
                    (BlocProvider.of<LoginBloc>(context).state as LoggedInState)
                        .student
                        .id));

            Navigator.of(context).popUntil(
              (route) => route.isFirst,
            );
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Successfully Registered for ${widget.driveName}!')));
          }
        },
        buildWhen: (previous, current) => current is RegisteringDriveState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Verify Details"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: state is RegisteringDriveState
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator())
                      : TextButton(
                          style: TextButton.styleFrom(
                              disabledBackgroundColor:
                                  Colors.grey.withAlpha(150)),
                          onPressed: personalDetailsEdited ||
                                  contactDetailsEdited ||
                                  undergraduateDetailsEdited ||
                                  intermediateDetailsEdited ||
                                  matricDetailsEdited
                              ? null
                              : () => BlocProvider.of<RegisterBloc>(context)
                                  .add(ApplyToDriveEvent(
                                      studentID:
                                          (BlocProvider.of<LoginBloc>(context)
                                                  .state as LoggedInState)
                                              .student
                                              .id,
                                      token:
                                          (BlocProvider.of<LoginBloc>(context)
                                                  .state as LoggedInState)
                                              .student
                                              .token,
                                      driveID: widget.driveID,
                                      selectedResume: widget.selectedResumeIdx,
                                      selectedRole: widget.selectedRole)),
                          child: Text(
                            "Apply",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          )),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PersonalDetailsCard(
                        onEdited: (value) => setState(() {
                          personalDetailsEdited = value;
                        }),
                        expansionTileController:
                            personalDetailsExpansionTileController,
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ContactDetailsCard(
                          onEdited: (value) => setState(() {
                                contactDetailsEdited = value;
                              }),
                          expansionTileController:
                              contactDetailsExpansionTileController),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: UndergraduateDetailsCard(
                        onEdited: (value) => setState(() {
                          undergraduateDetailsEdited = value;
                        }),
                        expansionTileController:
                            undergraduateDetailsExpansionTileController,
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: IntermediateSchoolDetailsCard(
                        onEdited: (value) => setState(() {
                          intermediateDetailsEdited = value;
                        }),
                        expansionTileController:
                            intermediateSchoolDetailsExpansionTileController,
                      ),
                    )),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MetricSchoolDetailsCard(
                        onEdited: (value) => setState(() {
                          matricDetailsEdited = value;
                        }),
                        expansionTileController:
                            metricSchoolDetailsExpansionTileController,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
