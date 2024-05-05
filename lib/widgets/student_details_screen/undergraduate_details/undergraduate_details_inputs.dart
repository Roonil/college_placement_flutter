import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class UndergraduateDetailsInputs extends StatelessWidget {
  final TextEditingController universityController,
      universityIdController,
      universityEmailController,
      degreeController,
      courseController,
      batchController,
      backlogsController,
      currentCgpaController;

  final GlobalKey<FormState> formKey;
  final bool isEdited, inputsEnabled;
  final Function(String) onChanged;

  const UndergraduateDetailsInputs(
      {super.key,
      required this.universityController,
      required this.universityIdController,
      required this.universityEmailController,
      required this.degreeController,
      required this.courseController,
      required this.currentCgpaController,
      required this.batchController,
      required this.backlogsController,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: universityEmailController,
                        textInputAction: TextInputAction.next,
                        validator: (email) =>
                            EmailValidator.validate(email ?? "")
                                ? null
                                : "Please enter a valid Email Address",
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("University Email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: universityIdController,
                        textInputAction: TextInputAction.next,
                        validator: (uid) =>
                            uid != null && uid.isNotEmpty && uid.length >= 3
                                ? null
                                : "Please enter a valid UID",
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("University ID"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: universityController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (name) {
                          final newName = RegExp(r"^[a-zA-Z ]+$");
                          try {
                            return (name != null && newName.hasMatch(name)
                                ? null
                                : "Please enter a valid University Name");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("University Name"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: batchController,
                        textInputAction: TextInputAction.next,
                        validator: (batch) {
                          final newName = RegExp(r"^(201[5-9]|202[0-9]|2030)$");
                          try {
                            return (batch?.length == 4 &&
                                    batch != null &&
                                    newName.hasMatch(batch)
                                ? null
                                : "Please enter a valid starting Year");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("Batch"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: currentCgpaController,
                        textInputAction: TextInputAction.next,
                        validator: (cgpa) {
                          final newName = RegExp(r"^(?:\d\.\d{1,2}|10\.0)$");
                          try {
                            return (cgpa != null && newName.hasMatch(cgpa)
                                ? null
                                : "Please enter a valid CGPA");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("CGPA(Eg. 8.0)"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: degreeController,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          final newName = RegExp(r"^[a-zA-Z ]+$");
                          try {
                            return (name != null && newName.hasMatch(name)
                                ? null
                                : "Please enter a valid Degree");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("Degree"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: courseController,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          final newName = RegExp(r"^[a-zA-Z ]+$");
                          try {
                            return (name != null && newName.hasMatch(name)
                                ? null
                                : "Please enter a valid Course");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("Course"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        enabled: inputsEnabled,
                        onChanged: onChanged,
                        controller: backlogsController,
                        textInputAction: TextInputAction.next,
                        validator: (name) {
                          final newName = RegExp(r"^(0|[1-9]|20)$");
                          try {
                            return (name != null && newName.hasMatch(name)
                                ? null
                                : "Please enter a valid Backlog");
                          } catch (_) {
                            return "not in range";
                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            label: const Text("Backlogs"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
