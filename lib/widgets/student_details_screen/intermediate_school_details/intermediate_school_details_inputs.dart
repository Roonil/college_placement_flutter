import 'package:flutter/material.dart';

class IntermediateSchoolDetailsInputs extends StatelessWidget {
  final TextEditingController schoolNameController,
      schoolCityController,
      percentageScoreController,
      boardController;

  final GlobalKey<FormState> formKey;
  final bool isEdited, inputsEnabled;
  final Function(String) onChanged;

  const IntermediateSchoolDetailsInputs(
      {super.key,
      required this.schoolNameController,
      required this.schoolCityController,
      required this.percentageScoreController,
      required this.boardController,
      required this.onChanged,
      required this.isEdited,
      required this.inputsEnabled,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    final Color requiredBorderColor = Theme.of(context).colorScheme.tertiary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              enabled: inputsEnabled,
              onChanged: onChanged,
              controller: schoolNameController,
              textInputAction: TextInputAction.next,
              validator: (spy) {
                final newName = RegExp(r"^[a-zA-Z ]+$");
                try {
                  return (spy != null && newName.hasMatch(spy)
                      ? null
                      : "Please enter a valid School");
                } catch (_) {
                  return "not in range";
                }
              },
              decoration: InputDecoration(
                  errorMaxLines: 4,
                  contentPadding: const EdgeInsets.all(8),
                  label: const Text("School"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: requiredBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Flexible(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              enabled: inputsEnabled,
              onChanged: onChanged,
              controller: schoolCityController,
              textInputAction: TextInputAction.next,
              validator: (spy) {
                final newName = RegExp(r"^[a-zA-Z ]+$");
                try {
                  return (spy != null && newName.hasMatch(spy)
                      ? null
                      : "Please enter a valid City");
                } catch (_) {
                  return "not in range";
                }
              },
              decoration: InputDecoration(
                  errorMaxLines: 4,
                  contentPadding: const EdgeInsets.all(8),
                  label: const Text("City"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: requiredBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Flexible(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              enabled: inputsEnabled,
              onChanged: onChanged,
              controller: percentageScoreController,
              textInputAction: TextInputAction.next,
              validator: (spy) {
                final newName = RegExp(
                    r"^100(?:\.0{1,2})?$|^\d{1,2}(?:\.\d{1,2})?$|^\.d{1,2}$");
                try {
                  return (spy != null && newName.hasMatch(spy)
                      ? null
                      : "Please enter a valid Percentage");
                } catch (_) {
                  return "not in range";
                }
              },
              decoration: InputDecoration(
                  errorMaxLines: 4,
                  contentPadding: const EdgeInsets.all(8),
                  label: const Text("Percentage Score (Eg. 92.80)"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: requiredBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Flexible(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              enabled: inputsEnabled,
              onChanged: onChanged,
              controller: boardController,
              textInputAction: TextInputAction.next,
              validator: (spy) {
                final newName = RegExp(r"^[a-zA-Z ]+$");
                try {
                  return (spy != null && newName.hasMatch(spy)
                      ? null
                      : "Please enter a exam Board");
                } catch (_) {
                  return "not in range";
                }
              },
              decoration: InputDecoration(
                  errorMaxLines: 4,
                  contentPadding: const EdgeInsets.all(8),
                  label: const Text("Exam Board"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: requiredBorderColor,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
      ],
    );
  }
}
