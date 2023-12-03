import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/personal_details_bloc.dart';
import '../bloc/personal_details_events.dart';
import '../bloc/personal_details_states.dart';
import '../models/personal_details.dart';

class PersonalDetailsCard extends StatefulWidget {
  const PersonalDetailsCard({super.key, required this.expansionTileController});

  final ExpansionTileController expansionTileController;

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

  bool showButtons = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listenWhen: (previous, current) =>
          (previous is FetchingPersonalDetailsState &&
              current is FetchedPersonalDetailsState) ||
          previous is UpdatingPersonalDetailsState &&
              current is UpdatedPersonalDetailsState,
      listener: (context, state) {
        if (state is FetchedPersonalDetailsState) {
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
        bool editedText =
            previousFirstName != firstNameController.text.trim() ||
                previousLastName != lastNameController.text.trim() ||
                previousDateOfBirth != dateOfBirthController.text.trim() ||
                previousNationality != nationalityController.text.trim();
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
                    showButtons = value;
                  }),
                  title: Text(
                    "Personal Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                state is FetchingPersonalDetailsState ||
                                        state is UpdatingPersonalDetailsState
                                    ? Icons.timer
                                    : editedText
                                        ? Icons.warning_amber_rounded
                                        : Icons.check_circle,
                                color: editedText ||
                                        state is FetchingPersonalDetailsState ||
                                        state is UpdatingPersonalDetailsState
                                    ? Colors.amber
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Flexible(
                              child: Text(state is FetchingPersonalDetailsState
                                  ? "Fetching Details"
                                  : state is UpdatingPersonalDetailsState
                                      ? "Updating Details"
                                      : editedText
                                          ? "Pending Changes"
                                          : "Details Up-to-Date"),
                            )
                          ],
                        ),
                      ),
                      (state is FetchedPersonalDetailsState ||
                                  state is UpdatedPersonalDetailsState) &&
                              showButtons &&
                              editedText
                          ? Wrap(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      //TODO: Add confirmation dialog
                                      firstNameController.text =
                                          previousFirstName ?? "";
                                      lastNameController.text =
                                          previousLastName ?? "";
                                      dateOfBirthController.text =
                                          previousDateOfBirth ?? "";
                                      nationalityController.text =
                                          previousNationality ?? "";
                                    },
                                    child: const Text("Undo Changes")),
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<PersonalDetailsBloc>(
                                              context)
                                          .add(UpdatePersonalDetailsEvent(
                                              studentID: "1",
                                              personalDetails: PersonalDetails(
                                                  dateOfBirth:
                                                      dateOfBirthController
                                                          .text
                                                          .trim(),
                                                  firstName:
                                                      firstNameController
                                                          .text
                                                          .trim(),
                                                  lastName: lastNameController
                                                      .text
                                                      .trim(),
                                                  nationality:
                                                      nationalityController.text
                                                          .trim())));
                                    },
                                    child: const Text("Save Changes")),
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                  children: [
                    //TODO: Skeletoniser

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state is FetchingPersonalDetailsState
                          ? const CircularProgressIndicator()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        flex: 7,
                                        child: TextFormField(
                                          onChanged: (_) => setState(() {}),
                                          controller: firstNameController,
                                          textInputAction: TextInputAction.next,
                                          validator: (firstName) => firstName ==
                                                      null ||
                                                  firstName.length < 3 ||
                                                  firstName.contains(
                                                      RegExp(r'[0-9]'))
                                              ? "Please enter a valid First Name"
                                              : null,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              label: const Text("First Name"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                      ),
                                      const Spacer(),
                                      //TODO: Make the required fields' borders some different color
                                      Flexible(
                                        flex: 7,
                                        child: TextFormField(
                                          onChanged: (_) => setState(() {}),
                                          controller: lastNameController,
                                          textInputAction: TextInputAction.next,
                                          validator: (lastName) => lastName ==
                                                      null ||
                                                  lastName.length < 3 ||
                                                  lastName.contains(
                                                      RegExp(r'[0-9]'))
                                              ? "Please enter a valid Last Name"
                                              : null,
                                          decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              label: const Text("Last Name"),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    onChanged: (_) => setState(() {}),
                                    controller: dateOfBirthController,
                                    textInputAction: TextInputAction.next,
                                    validator: (date) {
                                      if (date == null) {
                                        return "Please enter a valid Date of Birth";
                                      }
                                      try {
                                        DateFormat("dd/MM/yyyy").parse((date));
                                        return null;
                                      } catch (_) {
                                        return "Please enter a valid Date of Birth";
                                      }
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(8),
                                        suffixIcon: IconButton(
                                          icon:
                                              const Icon(Icons.calendar_month),
                                          onPressed: () async {
                                            DateTime currentDate;
                                            try {
                                              currentDate =
                                                  DateFormat("dd/MM/yyyy")
                                                      .parse(
                                                          (dateOfBirthController
                                                              .text));

                                              if (currentDate.isBefore(
                                                      DateTime(1993)) ||
                                                  currentDate.isAfter(
                                                      DateTime(2005))) {
                                                currentDate = DateTime(2000);
                                              }
                                            } catch (_) {
                                              currentDate = DateTime(2000);
                                            }

                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    initialEntryMode:
                                                        DatePickerEntryMode
                                                            .calendarOnly,
                                                    switchToInputEntryModeIcon:
                                                        null,
                                                    context:
                                                        context, //context of current state
                                                    initialDate: currentDate,
                                                    firstDate: DateTime(1993),
                                                    lastDate: DateTime(2005));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(pickedDate);

                                              dateOfBirthController.text =
                                                  formattedDate;
                                            }
                                          },
                                        ),
                                        label: const Text("Date of Birth"),
                                        hintText: "DD/MM/YYYY",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: nationalityController,
                                    onChanged: (_) => setState(() {}),
                                    onFieldSubmitted: (value) => formKey
                                                .currentState!
                                                .validate() &&
                                            editedText
                                        ? BlocProvider.of<PersonalDetailsBloc>(context)
                                            .add(UpdatePersonalDetailsEvent(
                                                studentID: "1",
                                                personalDetails: PersonalDetails(
                                                    dateOfBirth:
                                                        dateOfBirthController
                                                            .text
                                                            .trim(),
                                                    firstName:
                                                        firstNameController.text
                                                            .trim(),
                                                    lastName: lastNameController
                                                        .text
                                                        .trim(),
                                                    nationality:
                                                        nationalityController
                                                            .text
                                                            .trim())))
                                        : null,
                                    textInputAction: TextInputAction.go,
                                    validator: (nationality) => nationality ==
                                                null ||
                                            nationality
                                                .contains(RegExp(r'[0-9]')) ||
                                            nationality.length < 3
                                        ? "Please enter a valid Nationality"
                                        : null,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(8),
                                        label: const Text("Nationality"),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                ),
                              ],
                            ),
                    ),
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
