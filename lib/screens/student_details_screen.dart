import 'package:flutter/material.dart';

import '../widgets/student_details_screen/intermediate_school_details/intermediate_school_details_card.dart';
import '../widgets/student_details_screen/metric_school_details/metric_school_details_card.dart';
import '../widgets/student_details_screen/undergraduate_details/undergraduate_details_card.dart';
import '../widgets/student_details_screen/contact_details/contact_details_card.dart';
import '../widgets/student_details_screen/personal_details/personal_details_card.dart';

class StudentDetailsScreen extends StatefulWidget {
  final int selectedResumeIdx, selectedRoleIdx;
  const StudentDetailsScreen(
      {super.key,
      required this.selectedRoleIdx,
      required this.selectedResumeIdx});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final TextEditingController dateOfBirthController = TextEditingController();
  final ExpansionTileController personalDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController contactDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController undergraduateDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController metricSchoolDetailsExpansionTileController =
      ExpansionTileController();
  final ExpansionTileController
      intermediateSchoolDetailsExpansionTileController =
      ExpansionTileController();

  bool personalDetailsEdited = false,
      contactDetailsEdited = false,
      undergraduateDetailsEdited = false,
      intermediateDetailsEdited = false,
      matricDetailsEdited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Details"),
        actions: [
          TextButton(
              style: TextButton.styleFrom(
                  disabledBackgroundColor: Colors.grey.withAlpha(150)),
              onPressed: personalDetailsEdited ||
                      contactDetailsEdited ||
                      undergraduateDetailsEdited ||
                      intermediateDetailsEdited ||
                      matricDetailsEdited
                  ? null
                  : () {},
              child: Text(
                "Continue",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PersonalDetailsCard(
                  onEdited: (value) => setState(() {
                    personalDetailsEdited = value;
                  }),
                  expansionTileController:
                      personalDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ContactDetailsCard(
                    onEdited: (value) => setState(() {
                          contactDetailsEdited = value;
                        }),
                    expansionTileController:
                        contactDetailsExpansionTileController),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: UndergraduateDetailsCard(
                  onEdited: (value) => setState(() {
                    undergraduateDetailsEdited = value;
                  }),
                  expansionTileController:
                      undergraduateDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IntermediateSchoolDetailsCard(
                  onEdited: (value) => setState(() {
                    intermediateDetailsEdited = value;
                  }),
                  expansionTileController:
                      intermediateSchoolDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MetricSchoolDetailsCard(
                  onEdited: (value) => setState(() {
                    matricDetailsEdited = value;
                  }),
                  expansionTileController:
                      metricSchoolDetailsExpansionTileController,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
