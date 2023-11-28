import 'package:flutter/material.dart';

import '../widgets/contact_details_card.dart';
import '../widgets/personal_details_card.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final TextEditingController dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Details"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: PersonalDetailsCard(
                      dateOfBirthController: dateOfBirthController)),
              const Flexible(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ContactDetailsCard(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
