import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalDetailsCard extends StatelessWidget {
  const PersonalDetailsCard({
    super.key,
    required this.dateOfBirthController,
  });

  final TextEditingController dateOfBirthController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Personal Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (name) => name == null ||
                              name.length < 3 ||
                              name.contains(RegExp(r'[0-9]'))
                          ? "Please enter a valid First Name"
                          : null,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          label: const Text("First Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  const Spacer(),
                  //TODO: Make the required fields' borders some different color
                  Flexible(
                    flex: 7,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (name) => name == null ||
                              name.length < 3 ||
                              name.contains(RegExp(r'[0-9]'))
                          ? "Please enter a valid Last Name"
                          : null,
                      decoration: InputDecoration(
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
                    contentPadding: EdgeInsets.all(8),
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
                textInputAction: TextInputAction.next,
                validator: (nationality) => nationality == null ||
                        nationality.contains(RegExp(r'[0-9]')) ||
                        nationality.length < 3
                    ? "Please enter a valid Nationality"
                    : null,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    label: const Text("Nationality"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
