import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/intermediate_school_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchIntermediateSchoolDetailsEvent implements ContactDetailsEvent {
  final String studentID;

  const FetchIntermediateSchoolDetailsEvent({required this.studentID});
}

@immutable
class UpdateIntermediateSchoolDetailsEvent implements ContactDetailsEvent {
  final String studentID;
  final IntermediateSchoolDetails intermediateSchoolDetails;
  const UpdateIntermediateSchoolDetailsEvent(
      {required this.studentID, required this.intermediateSchoolDetails});
}
