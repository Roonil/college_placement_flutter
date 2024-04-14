import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/metric_school_details_bloc.dart';
import '../../../bloc/details_blocs/metric_school_details_events.dart';
import '../../../bloc/details_blocs/metric_school_details_states.dart';
import '../../../models/metric_school_details.dart';
import '../details_subtitle.dart';
import './metric_school_details_inputs.dart';

class MetricSchoolDetailsCard extends StatefulWidget {
  const MetricSchoolDetailsCard(
      {super.key, required this.expansionTileController});

  final ExpansionTileController expansionTileController;

  @override
  State<MetricSchoolDetailsCard> createState() =>
      _MetricSchoolDetailsCardState();
}

class _MetricSchoolDetailsCardState extends State<MetricSchoolDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolCityController = TextEditingController();
  final TextEditingController passingYearController = TextEditingController();
  final TextEditingController percentageScoreController =
      TextEditingController();
  final TextEditingController boardController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  String? previousSchoolName,
      previousSchoolCity,
      previousPassingYear,
      previousPercentageScore,
      previousBoard,
      previousMedium;

  bool shouldShowButtons = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MetricSchoolDetailsBloc, MetricSchoolDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingMetricSchoolDetailsState &&
              current is FetchedMetricSchoolDetailsState) ||
          previous is UpdatingMetricSchoolDetailsState &&
              current is UpdatedMetricSchoolDetailsState,
      listener: (context, state) {
        if (state is FetchedMetricSchoolDetailsState) {
          schoolNameController.text = state.metricSchoolDetails.schoolName;
          schoolCityController.text = state.metricSchoolDetails.schoolCity;
          passingYearController.text = state.metricSchoolDetails.passingYear;
          percentageScoreController.text =
              state.metricSchoolDetails.percentageScore;
          boardController.text = state.metricSchoolDetails.board;
          mediumController.text = state.metricSchoolDetails.medium;

          previousSchoolName = schoolNameController.text.trim();
          previousSchoolCity = schoolCityController.text.trim();
          previousPassingYear = passingYearController.text.trim();
          previousPercentageScore = percentageScoreController.text.trim();
          previousBoard = boardController.text.trim();
          previousMedium = mediumController.text.trim();
        } else if (state is UpdatedMetricSchoolDetailsState) {
          previousSchoolName = schoolNameController.text.trim();
          previousSchoolCity = schoolCityController.text.trim();
          previousPassingYear = passingYearController.text.trim();
          previousPercentageScore = percentageScoreController.text.trim();
          previousBoard = boardController.text.trim();
          previousMedium = mediumController.text.trim();
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedMetricSchoolDetailsState ||
              current is MetricSchoolDetailsFetchFailedState ||
              current is FetchingMetricSchoolDetailsState ||
              current is UpdatedMetricSchoolDetailsState ||
              current is UpdatingMetricSchoolDetailsState ||
              current is MetricSchoolDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited = previousSchoolName !=
                schoolNameController.text.trim() ||
            previousSchoolCity != schoolCityController.text.trim() ||
            previousPassingYear != passingYearController.text.trim() ||
            previousPercentageScore != percentageScoreController.text.trim() ||
            previousBoard != boardController.text.trim() ||
            previousMedium != mediumController.text.trim();
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
                    "Xth Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: DetailsSubtitle(
                    hasFetched: state is FetchedMetricSchoolDetailsState,
                    hasUpdated: state is UpdatedMetricSchoolDetailsState,
                    isFetching: state is FetchingMetricSchoolDetailsState,
                    isUpdating: state is UpdatingMetricSchoolDetailsState,
                    isEdited: isEdited,
                    onSaved: () {
                      formKey.currentState!.validate() && isEdited
                          ? BlocProvider.of<MetricSchoolDetailsBloc>(context)
                              .add(UpdateMetricSchoolDetailsEvent(
                                  //TODO: Sync Student details from logged in details
                                  studentID: "1",
                                  metricSchoolDetails: MetricSchoolDetails(
                                      schoolName:
                                          schoolNameController.text.trim(),
                                      schoolCity:
                                          schoolCityController.text.trim(),
                                      passingYear:
                                          passingYearController.text.trim(),
                                      percentageScore:
                                          percentageScoreController.text.trim(),
                                      board: boardController.text.trim(),
                                      medium: mediumController.text.trim())))
                          : null;
                    },
                    onUndo: () {
                      setState(() {
                        schoolNameController.text = previousSchoolName ?? "";
                        schoolCityController.text = previousSchoolCity ?? "";
                        passingYearController.text = previousPassingYear ?? "";
                        percentageScoreController.text =
                            previousPercentageScore ?? "";
                        boardController.text = previousBoard ?? "";
                        mediumController.text = previousMedium ?? "";
                      });
                    },
                    shouldShowButtons: shouldShowButtons,
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state is FetchingMetricSchoolDetailsState
                            ? Skeletonizer(
                                effect: ShimmerEffect(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5)),
                                child: MetricSchoolDetailsInputs(
                                  schoolNameController: schoolNameController,
                                  schoolCityController: schoolCityController,
                                  passingYearController: passingYearController,
                                  percentageScoreController:
                                      percentageScoreController,
                                  boardController: boardController,
                                  mediumController: mediumController,
                                  isEdited: false,
                                  inputsEnabled: true,
                                  formKey: formKey,
                                  onChanged: (_) {},
                                ))
                            : MetricSchoolDetailsInputs(
                                schoolNameController: schoolNameController,
                                schoolCityController: schoolCityController,
                                passingYearController: passingYearController,
                                percentageScoreController:
                                    percentageScoreController,
                                boardController: boardController,
                                mediumController: mediumController,
                                isEdited: isEdited,
                                inputsEnabled:
                                    state is! UpdatingMetricSchoolDetailsState,
                                formKey: formKey,
                                onChanged: (_) => setState(() {}),
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
