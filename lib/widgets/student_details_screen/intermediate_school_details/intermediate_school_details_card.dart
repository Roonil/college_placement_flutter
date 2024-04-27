import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/intermediate_school_details_bloc.dart';
import '../../../bloc/details_blocs/intermediate_school_details_events.dart';
import '../../../bloc/details_blocs/intermediate_school_details_states.dart';
import '../../../bloc/login_bloc.dart';
import '../../../bloc/login_bloc_states.dart';
import '../../../models/intermediate_school_details.dart';
import '../details_subtitle.dart';
import './intermediate_school_details_inputs.dart';

class IntermediateSchoolDetailsCard extends StatefulWidget {
  const IntermediateSchoolDetailsCard(
      {super.key,
      required this.expansionTileController,
      required this.onEdited});

  final Function(bool) onEdited;
  final ExpansionTileController expansionTileController;

  @override
  State<IntermediateSchoolDetailsCard> createState() =>
      _IntermediateSchoolDetailsCardState();
}

class _IntermediateSchoolDetailsCardState
    extends State<IntermediateSchoolDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolCityController = TextEditingController();

  final TextEditingController percentageScoreController =
      TextEditingController();
  final TextEditingController boardController = TextEditingController();

  String? previousSchoolName,
      previousSchoolCity,
      previousPercentageScore,
      previousBoard;

  bool shouldShowButtons = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntermediateSchoolDetailsBloc,
        IntermediateSchoolDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingIntermediateSchoolDetailsState &&
              current is FetchedIntermediateSchoolDetailsState) ||
          previous is UpdatingIntermediateSchoolDetailsState &&
              current is UpdatedIntermediateSchoolDetailsState,
      listener: (context, state) {
        if (state is FetchedIntermediateSchoolDetailsState) {
          schoolNameController.text =
              state.intermediateSchoolDetails.schoolName;
          schoolCityController.text =
              state.intermediateSchoolDetails.schoolCity;

          percentageScoreController.text =
              state.intermediateSchoolDetails.percentageScore;
          boardController.text = state.intermediateSchoolDetails.board;

          previousSchoolName = schoolNameController.text.trim();
          previousSchoolCity = schoolCityController.text.trim();

          previousPercentageScore = percentageScoreController.text.trim();
          previousBoard = boardController.text.trim();
        } else if (state is UpdatedIntermediateSchoolDetailsState) {
          previousSchoolName = schoolNameController.text.trim();
          previousSchoolCity = schoolCityController.text.trim();
          previousPercentageScore = percentageScoreController.text.trim();
          previousBoard = boardController.text.trim();
          widget.onEdited(false);
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedIntermediateSchoolDetailsState ||
              current is IntermediateSchoolDetailsFetchFailedState ||
              current is FetchingIntermediateSchoolDetailsState ||
              current is UpdatedIntermediateSchoolDetailsState ||
              current is UpdatingIntermediateSchoolDetailsState ||
              current is IntermediateSchoolDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited = previousSchoolName !=
                schoolNameController.text.trim() ||
            previousSchoolCity != schoolCityController.text.trim() ||
            previousPercentageScore != percentageScoreController.text.trim() ||
            previousBoard != boardController.text.trim();
        return Card(
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                    "XIIth Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: DetailsSubtitle(
                    hasFetched: state is FetchedIntermediateSchoolDetailsState,
                    hasUpdated: state is UpdatedIntermediateSchoolDetailsState,
                    isFetching: state is FetchingIntermediateSchoolDetailsState,
                    isUpdating: state is UpdatingIntermediateSchoolDetailsState,
                    isEdited: isEdited,
                    onSaved: () {
                      formKey.currentState!.validate() && isEdited
                          ? BlocProvider.of<IntermediateSchoolDetailsBloc>(
                                  context)
                              .add(UpdateIntermediateSchoolDetailsEvent(
                                  //TODO: Sync Student details from logged in details
                                  studentID:
                                      (BlocProvider.of<LoginBloc>(context).state
                                              as LoggedInState)
                                          .student
                                          .id,
                                  token: (BlocProvider.of<LoginBloc>(context)
                                          .state as LoggedInState)
                                      .student
                                      .token,
                                  intermediateSchoolDetails:
                                      IntermediateSchoolDetails(
                                    schoolName:
                                        schoolNameController.text.trim(),
                                    schoolCity:
                                        schoolCityController.text.trim(),
                                    percentageScore:
                                        percentageScoreController.text.trim(),
                                    board: boardController.text.trim(),
                                  )))
                          : null;
                    },
                    onUndo: () {
                      schoolNameController.text = previousSchoolName ?? "";
                      schoolCityController.text = previousSchoolCity ?? "";

                      percentageScoreController.text =
                          previousPercentageScore ?? "";
                      boardController.text = previousBoard ?? "";
                      widget.onEdited(false);
                    },
                    shouldShowButtons: shouldShowButtons,
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state is FetchingIntermediateSchoolDetailsState
                            ? Skeletonizer(
                                effect: ShimmerEffect(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5)),
                                child: IntermediateSchoolDetailsInputs(
                                  schoolNameController: schoolNameController,
                                  schoolCityController: schoolCityController,
                                  percentageScoreController:
                                      percentageScoreController,
                                  boardController: boardController,
                                  isEdited: false,
                                  inputsEnabled: true,
                                  formKey: formKey,
                                  onChanged: (_) {},
                                ))
                            : IntermediateSchoolDetailsInputs(
                                schoolNameController: schoolNameController,
                                schoolCityController: schoolCityController,
                                percentageScoreController:
                                    percentageScoreController,
                                boardController: boardController,
                                isEdited: isEdited,
                                inputsEnabled: state
                                    is! UpdatingIntermediateSchoolDetailsState,
                                formKey: formKey,
                                onChanged: (_) {
                                  isEdited = previousSchoolName !=
                                          schoolNameController.text.trim() ||
                                      previousSchoolCity !=
                                          schoolCityController.text.trim() ||
                                      previousPercentageScore !=
                                          percentageScoreController.text
                                              .trim() ||
                                      previousBoard !=
                                          boardController.text.trim();
                                  widget.onEdited(isEdited);
                                },
                              )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
