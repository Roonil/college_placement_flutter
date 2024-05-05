import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/undergraduate_details_bloc.dart';
import '../../../bloc/details_blocs/undergraduate_details_states.dart';
import '../../../bloc/details_blocs/undergraduate_details_events.dart';
import '../../../bloc/login_bloc.dart';
import '../../../bloc/login_bloc_states.dart';
import '../../../models/undergraduate_details.dart';
import '../details_subtitle.dart';
import './undergraduate_details_inputs.dart';

class UndergraduateDetailsCard extends StatefulWidget {
  const UndergraduateDetailsCard(
      {super.key,
      required this.expansionTileController,
      required this.onEdited});
  final ExpansionTileController expansionTileController;
  final Function(bool) onEdited;
  @override
  State<UndergraduateDetailsCard> createState() =>
      _UndergraduateDetailsCardState();
}

class _UndergraduateDetailsCardState extends State<UndergraduateDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController universityController = TextEditingController();
  final TextEditingController universityIdController = TextEditingController();
  final TextEditingController universityEmailController =
      TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController currentCgpaController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController backlogsController = TextEditingController();
  String? previousUniversity,
      previousUniversityId,
      previousUniversityEmail,
      previousDegree,
      previousCourse,
      previousBatch,
      previousBacklogs,
      previousCurrentCgpa;

  bool shouldShowButtons = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UndergraduateDetailsBloc, UndergraduateDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingUndergraduateDetailsState &&
              current is FetchedUndergraduateDetailsState) ||
          (previous is UpdatingUndergraduateDetailsState &&
              current is UpdatedUndergraduateDetailsState) ||
          (previous is FetchingUndergraduateDetailsState &&
              current is UndergraduateDetailsFetchFailedState) ||
          (previous is UpdatingUndergraduateDetailsState &&
              current is UndergraduateDetailsUpdateFailedState),
      listener: (context, state) {
        if (state is UndergraduateDetailsFetchFailedState ||
            state is UndergraduateDetailsUpdateFailedState) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.authError.toString().split(": ")[1])));
        } else if (state is FetchedUndergraduateDetailsState) {
          universityController.text = state.undergraduateDetails.university;
          universityIdController.text = state.undergraduateDetails.universityID;
          universityEmailController.text =
              state.undergraduateDetails.universityEmail;
          degreeController.text = state.undergraduateDetails.degree;
          courseController.text = state.undergraduateDetails.course;
          batchController.text = state.undergraduateDetails.batch.toString();
          backlogsController.text =
              state.undergraduateDetails.backlogs.toString();
          currentCgpaController.text =
              state.undergraduateDetails.currentCgpa.toString();
          previousUniversity = universityController.text.trim();
          previousUniversityId = universityIdController.text.trim();
          previousUniversityEmail = universityEmailController.text.trim();
          previousDegree = degreeController.text.trim();
          previousCourse = courseController.text.trim();
          previousBatch = batchController.text.trim();
          previousBacklogs = backlogsController.text.trim();
          previousCurrentCgpa = currentCgpaController.text.trim();
        } else if (state is UpdatedUndergraduateDetailsState) {
          previousUniversity = universityController.text.trim();
          previousUniversityId = universityIdController.text.trim();
          previousUniversityEmail = universityEmailController.text.trim();
          previousDegree = degreeController.text.trim();
          previousCourse = courseController.text.trim();
          previousBatch = batchController.text.trim();
          previousBacklogs = backlogsController.text.trim();
          previousCurrentCgpa = currentCgpaController.text.trim();
          widget.onEdited(false);
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedUndergraduateDetailsState ||
              current is UndergraduateDetailsFetchFailedState ||
              current is FetchingUndergraduateDetailsState ||
              current is UpdatedUndergraduateDetailsState ||
              current is UpdatingUndergraduateDetailsState ||
              current is UndergraduateDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited = previousUniversity !=
                universityController.text.trim() ||
            previousUniversityId != universityIdController.text.trim() ||
            previousUniversityEmail != universityEmailController.text.trim() ||
            previousDegree != degreeController.text.trim() ||
            previousCourse != courseController.text.trim() ||
            previousBatch != batchController.text.trim() ||
            previousBacklogs != backlogsController.text.trim() ||
            previousCurrentCgpa != currentCgpaController.text.trim();
        return Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Form(
                    key: formKey,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                          controller: widget.expansionTileController,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onExpansionChanged: (value) => setState(() {
                                shouldShowButtons = value;
                              }),
                          title: Text(
                            "UG Details",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: DetailsSubtitle(
                            hasFetched:
                                state is FetchedUndergraduateDetailsState,
                            hasUpdated:
                                state is UpdatedUndergraduateDetailsState,
                            isFetching:
                                state is FetchingUndergraduateDetailsState,
                            isUpdating:
                                state is UpdatingUndergraduateDetailsState,
                            isEdited: isEdited,
                            onSaved: () {
                              formKey.currentState!.validate() && isEdited
                                  ? BlocProvider.of<UndergraduateDetailsBloc>(context).add(UpdateUndergraduateDetailsEvent(
                                      studentID:
                                          (BlocProvider.of<LoginBloc>(context)
                                                  .state as LoggedInState)
                                              .student
                                              .id,
                                      token: (BlocProvider.of<LoginBloc>(context)
                                              .state as LoggedInState)
                                          .student
                                          .token,
                                      undergraduateDetails: UndergraduateDetails(
                                          university:
                                              universityController.text.trim(),
                                          universityID: universityIdController
                                              .text
                                              .trim(),
                                          universityEmail:
                                              universityEmailController.text.trim(),
                                          degree: degreeController.text.trim(),
                                          course: courseController.text.trim(),
                                          batch: int.parse(batchController.text.trim()),
                                          backlogs: int.parse(backlogsController.text.trim()),
                                          currentCgpa: double.parse(currentCgpaController.text.trim()))))
                                  : null;
                            },
                            onUndo: () {
                              universityController.text =
                                  previousUniversity ?? "";
                              universityIdController.text =
                                  previousUniversityId ?? "";
                              universityEmailController.text =
                                  previousUniversityEmail ?? "";
                              degreeController.text = previousDegree ?? "";
                              courseController.text = previousCourse ?? "";

                              backlogsController.text = previousBacklogs ?? "";

                              batchController.text = previousBatch ?? "";

                              currentCgpaController.text =
                                  previousCurrentCgpa ?? "";
                              widget.onEdited(false);
                            },
                            shouldShowButtons: shouldShowButtons,
                          ),
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: state
                                        is FetchingUndergraduateDetailsState
                                    ? Skeletonizer(
                                        effect: ShimmerEffect(
                                            baseColor: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(.5)),
                                        child: UndergraduateDetailsInputs(
                                          universityController:
                                              universityController,
                                          universityIdController:
                                              universityIdController,
                                          universityEmailController:
                                              universityEmailController,
                                          degreeController: degreeController,
                                          courseController: courseController,
                                          batchController: batchController,
                                          backlogsController:
                                              backlogsController,
                                          currentCgpaController:
                                              currentCgpaController,
                                          isEdited: false,
                                          inputsEnabled: true,
                                          formKey: formKey,
                                          onChanged: (_) {},
                                        ))
                                    : UndergraduateDetailsInputs(
                                        universityController:
                                            universityController,
                                        universityIdController:
                                            universityIdController,
                                        universityEmailController:
                                            universityEmailController,
                                        degreeController: degreeController,
                                        courseController: courseController,
                                        batchController: batchController,
                                        backlogsController: backlogsController,
                                        currentCgpaController:
                                            currentCgpaController,
                                        isEdited: isEdited,
                                        inputsEnabled: state
                                            is! UpdatingUndergraduateDetailsState,
                                        formKey: formKey,
                                        onChanged: (_) {
                                          isEdited = previousUniversity !=
                                                  universityController.text
                                                      .trim() ||
                                              previousUniversityId !=
                                                  universityIdController.text
                                                      .trim() ||
                                              previousUniversityEmail !=
                                                  universityEmailController.text
                                                      .trim() ||
                                              previousDegree !=
                                                  degreeController.text
                                                      .trim() ||
                                              previousCourse !=
                                                  courseController.text
                                                      .trim() ||
                                              previousBatch !=
                                                  batchController.text.trim() ||
                                              previousBacklogs !=
                                                  backlogsController.text
                                                      .trim() ||
                                              previousCurrentCgpa !=
                                                  currentCgpaController.text
                                                      .trim();

                                          widget.onEdited(isEdited);
                                        },
                                      )),
                          ]),
                    ))));
      },
    );
  }
}
