import 'package:flutter/material.dart';

import '../widgets/student_details_screen/intermediate_school_details/intermediate_school_details_card.dart';
import '../widgets/student_details_screen/metric_school_details/metric_school_details_card.dart';
import '../widgets/student_details_screen/undergraduate_details/undergraduate_details_card.dart';
import '../widgets/student_details_screen/contact_details/contact_details_card.dart';
import '../widgets/student_details_screen/personal_details/personal_details_card.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Details"),
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
                  expansionTileController:
                      personalDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ContactDetailsCard(
                    expansionTileController:
                        contactDetailsExpansionTileController),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: UndergraduateDetailsCard(
                  expansionTileController:
                      undergraduateDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: IntermediateSchoolDetailsCard(
                  expansionTileController:
                      intermediateSchoolDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MetricSchoolDetailsCard(
                  expansionTileController:
                      metricSchoolDetailsExpansionTileController,
                ),
              )),
              Flexible(
                  child: TextButton(
                child: const Text("Register"),
                onPressed: () {},
              ))
            ],
          ),
        ),
      ),
    );
  }
}
