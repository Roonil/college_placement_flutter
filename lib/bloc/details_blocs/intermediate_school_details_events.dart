import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/intermediate_school_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchIntermediateSchoolDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;

  const FetchIntermediateSchoolDetailsEvent(
      {required this.studentID, required this.token});
}

@immutable
class UpdateIntermediateSchoolDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;
  final IntermediateSchoolDetails intermediateSchoolDetails;
  const UpdateIntermediateSchoolDetailsEvent(
      {required this.studentID,
      required this.intermediateSchoolDetails,
      required this.token});
}
