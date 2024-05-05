import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalDetailsInputs extends StatelessWidget {
  final TextEditingController firstNameController,
      lastNameController,
      dateOfBirthController,
      nationalityController;

  final GlobalKey<FormState> formKey;
  final bool isEdited, inputsEnabled;
  final Function(String) onChanged;

  const PersonalDetailsInputs(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.dateOfBirthController,
      required this.nationalityController,
      required this.onChanged,
      required this.isEdited,
      required this.inputsEnabled,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 7,
                child: TextFormField(
                  enabled: inputsEnabled,
                  onChanged: onChanged,
                  controller: firstNameController,
                  textInputAction: TextInputAction.next,
                  validator: (firstName) => firstName == null ||
                          firstName.length < 3 ||
                          firstName.contains(RegExp(r'[0-9]'))
                      ? "Please enter a valid First Name"
                      : null,
                  decoration: InputDecoration(
                      errorMaxLines: 4,
                      contentPadding: const EdgeInsets.all(8),
                      label: const Text("First Name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 7,
                child: TextFormField(
                  enabled: inputsEnabled,
                  onChanged: onChanged,
                  controller: lastNameController,
                  textInputAction: TextInputAction.next,
                  validator: (lastName) => lastName == null ||
                          lastName.length < 3 ||
                          lastName.contains(RegExp(r'[0-9]'))
                      ? "Please enter a valid Last Name"
                      : null,
                  decoration: InputDecoration(
                      errorMaxLines: 4,
                      contentPadding: const EdgeInsets.all(8),
                      label: const Text("Last Name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            enabled: inputsEnabled,
            onChanged: onChanged,
            controller: dateOfBirthController,
            textInputAction: TextInputAction.next,
            validator: (date) {
              if (date == null) {
                return "Please enter a valid Date of Birth";
              }
              try {
                final DateTime currentDate =
                    DateFormat("dd/MM/yyyy").parse((date));
                if ("${currentDate.day.toString().padLeft(2, '0')}/${currentDate.month.toString().padLeft(2, '0')}/${currentDate.year}" !=
                        date ||
                    currentDate.isBefore(DateTime(1993)) ||
                    currentDate.isAfter(DateTime(2005))) {
                  return "Plesase enter a valid Date of Birth";
                }

                return null;
              } catch (_) {
                return "Please enter a valid Date of Birth";
              }
            },
            decoration: InputDecoration(
                errorMaxLines: 4,
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () async {
                    DateTime currentDate;
                    try {
                      currentDate = DateFormat("dd/MM/yyyy")
                          .parse((dateOfBirthController.text));

                      if (currentDate.isBefore(DateTime(1993)) ||
                          currentDate.isAfter(DateTime(2005))) {
                        currentDate = DateTime(2000);
                      }
                    } catch (_) {
                      currentDate = DateTime(2000);
                    }

                    DateTime? pickedDate = await showDatePicker(
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        switchToInputEntryModeIcon: null,
                        context: context, //context of current state
                        initialDate: currentDate,
                        firstDate: DateTime(1993),
                        lastDate: DateTime(2005));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                      dateOfBirthController.text = formattedDate;

                      if (pickedDate != currentDate) {
                        onChanged("");
                      }
                    }
                  },
                ),
                label: const Text("Date of Birth"),
                hintText: "DD/MM/YYYY",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            enabled: inputsEnabled,
            controller: nationalityController,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            validator: (nationality) => nationality == null ||
                    nationality.contains(RegExp(r'[0-9]')) ||
                    nationality.length < 3
                ? "Please enter a valid Nationality"
                : null,
            decoration: InputDecoration(
                errorMaxLines: 4,
                contentPadding: const EdgeInsets.all(8),
                label: const Text("Nationality"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
      ],
    );
  }
}
