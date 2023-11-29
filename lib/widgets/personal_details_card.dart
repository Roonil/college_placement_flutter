import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/personal_details_bloc.dart';
import '../bloc/personal_details_states.dart';

class PersonalDetailsCard extends StatefulWidget {
  const PersonalDetailsCard({super.key, required this.expansionTileController});

  final ExpansionTileController expansionTileController;

  @override
  State<PersonalDetailsCard> createState() => _PersonalDetailsCardState();
}

class _PersonalDetailsCardState extends State<PersonalDetailsCard> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
      listenWhen: (previous, current) =>
          previous is FetchingPersonalDetailsState &&
          current is FetchedPersonalDetailsState,
      listener: (context, state) {
        if (state is FetchedPersonalDetailsState) {
          firstNameController.text = state.personalDetails.firstName;
          lastNameController.text = state.personalDetails.lastName;
          dateOfBirthController.text = state.personalDetails.dateOfBirth;
          nationalityController.text = state.personalDetails.nationality;
        }
      },
      buildWhen: (previous, current) =>
          (previous is FetchingPersonalDetailsState &&
              current is FetchedPersonalDetailsState) ||
          (previous is FetchingPersonalDetailsState &&
              current is PersonalDetailsFetchFailedState),
      builder: (context, state) => Card(
        elevation: 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Card(
            margin: EdgeInsets.zero,
            child: ExpansionTile(
              controller: widget.expansionTileController,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                "Personal Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      state is FetchingPersonalDetailsState
                          ? Icons.timer
                          : Icons.check_circle,
                      color: state is FetchingPersonalDetailsState
                          ? Colors.amber
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(state is FetchedPersonalDetailsState
                      ? "Details Up-to-Date"
                      : "Fetching Details")
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
                                      controller: firstNameController,
                                      textInputAction: TextInputAction.next,
                                      validator: (firstName) => firstName ==
                                                  null ||
                                              firstName.length < 3 ||
                                              firstName
                                                  .contains(RegExp(r'[0-9]'))
                                          ? "Please enter a valid First Name"
                                          : null,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          label: const Text("First Name"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  ),
                                  const Spacer(),
                                  //TODO: Make the required fields' borders some different color
                                  Flexible(
                                    flex: 7,
                                    child: TextFormField(
                                      controller: lastNameController,
                                      textInputAction: TextInputAction.next,
                                      validator: (lastName) => lastName ==
                                                  null ||
                                              lastName.length < 3 ||
                                              lastName
                                                  .contains(RegExp(r'[0-9]'))
                                          ? "Please enter a valid Last Name"
                                          : null,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(8),
                                          label: const Text("Last Name"),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
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
                                      icon: const Icon(Icons.calendar_month),
                                      onPressed: () async {
                                        DateTime currentDate;
                                        try {
                                          currentDate = DateFormat("dd/MM/yyyy")
                                              .parse(
                                                  (dateOfBirthController.text));

                                          if (currentDate
                                                  .isBefore(DateTime(1993)) ||
                                              currentDate
                                                  .isAfter(DateTime(2005))) {
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
                                textInputAction: TextInputAction.next,
                                validator: (nationality) =>
                                    nationality == null ||
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
  }
}
