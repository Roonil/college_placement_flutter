import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../bloc/details_blocs/personal_details_bloc.dart';
import '../../../bloc/details_blocs/personal_details_events.dart';
import '../../../bloc/details_blocs/personal_details_states.dart';
import '../../../bloc/login_bloc.dart';
import '../../../bloc/login_bloc_states.dart';
import '../../../models/personal_details.dart';
import '../details_subtitle.dart';
import './personal_details_inputs.dart';

class PersonalDetailsCard extends StatefulWidget {
  const PersonalDetailsCard(
      {super.key,
      required this.expansionTileController,
      required this.onEdited});

  final ExpansionTileController expansionTileController;
  final Function(bool) onEdited;
  @override
  State<PersonalDetailsCard> createState() => _PersonalDetailsCardState();
}

class _PersonalDetailsCardState extends State<PersonalDetailsCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  String? previousFirstName,
      previousLastName,
      previousDateOfBirth,
      previousNationality;

  bool shouldShowButtons = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingPersonalDetailsState &&
              current is FetchedPersonalDetailsState) ||
          (previous is UpdatingPersonalDetailsState &&
              current is UpdatedPersonalDetailsState) ||
          (previous is FetchingPersonalDetailsState &&
              current is PersonalDetailsFetchFailedState) ||
          (previous is UpdatingPersonalDetailsState &&
              current is PersonalDetailsUpdateFailedState),
      listener: (context, state) {
        if (state is PersonalDetailsFetchFailedState ||
            state is PersonalDetailsUpdateFailedState) {
          ScaffoldMessenger.of(context).clearSnackBars();

          (SnackBar(content: Text(state.authError.toString().split(": ")[1])));
        } else if (state is FetchedPersonalDetailsState) {
          firstNameController.text = state.personalDetails.firstName;
          lastNameController.text = state.personalDetails.lastName;
          dateOfBirthController.text = state.personalDetails.dateOfBirth;
          nationalityController.text = state.personalDetails.nationality;
          previousFirstName = firstNameController.text.trim();
          previousLastName = lastNameController.text.trim();
          previousDateOfBirth = dateOfBirthController.text.trim();
          previousNationality = nationalityController.text.trim();
        } else if (state is UpdatedPersonalDetailsState) {
          previousFirstName = firstNameController.text.trim();
          previousLastName = lastNameController.text.trim();
          previousDateOfBirth = dateOfBirthController.text.trim();
          previousNationality = nationalityController.text.trim();

          widget.onEdited(false);
        }
      },
      buildWhen: (previous, current) =>
          (current is FetchedPersonalDetailsState ||
              current is PersonalDetailsFetchFailedState ||
              current is FetchingPersonalDetailsState ||
              current is UpdatedPersonalDetailsState ||
              current is UpdatingPersonalDetailsState ||
              current is PersonalDetailsUpdateFailedState) &&
          previous != current,
      builder: (context, state) {
        bool isEdited = previousFirstName != firstNameController.text.trim() ||
            previousLastName != lastNameController.text.trim() ||
            previousDateOfBirth != dateOfBirthController.text.trim() ||
            previousNationality != nationalityController.text.trim();

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
                    "Personal Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: DetailsSubtitle(
                    hasFetched: state is FetchedPersonalDetailsState,
                    hasUpdated: state is UpdatedPersonalDetailsState,
                    isFetching: state is FetchingPersonalDetailsState,
                    isUpdating: state is UpdatingPersonalDetailsState,
                    isEdited: isEdited,
                    onSaved: () {
                      formKey.currentState!.validate() && isEdited
                          ? BlocProvider.of<PersonalDetailsBloc>(context).add(
                              UpdatePersonalDetailsEvent(
                                  token: (BlocProvider.of<LoginBloc>(context)
                                          .state as LoggedInState)
                                      .student
                                      .token,
                                  studentID:
                                      (BlocProvider.of<LoginBloc>(context).state
                                              as LoggedInState)
                                          .student
                                          .id,
                                  personalDetails: PersonalDetails(
                                      dateOfBirth:
                                          dateOfBirthController.text.trim(),
                                      firstName:
                                          firstNameController.text.trim(),
                                      lastName: lastNameController.text.trim(),
                                      nationality:
                                          nationalityController.text.trim())))
                          : null;
                    },
                    onUndo: () {
                      firstNameController.text = previousFirstName ?? "";
                      lastNameController.text = previousLastName ?? "";
                      dateOfBirthController.text = previousDateOfBirth ?? "";
                      nationalityController.text = previousNationality ?? "";
                      widget.onEdited(false);
                    },
                    shouldShowButtons: shouldShowButtons,
                  ),
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: state is FetchingPersonalDetailsState
                            ? Skeletonizer(
                                effect: ShimmerEffect(
                                    baseColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5)),
                                child: PersonalDetailsInputs(
                                  firstNameController: firstNameController,
                                  lastNameController: lastNameController,
                                  dateOfBirthController: dateOfBirthController,
                                  nationalityController: nationalityController,
                                  isEdited: false,
                                  inputsEnabled: true,
                                  formKey: formKey,
                                  onChanged: (_) {},
                                ))
                            : PersonalDetailsInputs(
                                firstNameController: firstNameController,
                                lastNameController: lastNameController,
                                dateOfBirthController: dateOfBirthController,
                                nationalityController: nationalityController,
                                isEdited: isEdited,
                                inputsEnabled:
                                    state is! UpdatingPersonalDetailsState,
                                formKey: formKey,
                                onChanged: (value) {
                                  // setState(() {});
                                  isEdited = previousFirstName !=
                                          firstNameController.text.trim() ||
                                      previousLastName !=
                                          lastNameController.text.trim() ||
                                      previousDateOfBirth !=
                                          dateOfBirthController.text.trim() ||
                                      previousNationality !=
                                          nationalityController.text.trim();
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
