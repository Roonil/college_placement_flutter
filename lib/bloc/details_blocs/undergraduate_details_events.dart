import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/undergraduate_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchUndergraduateDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;

  const FetchUndergraduateDetailsEvent(
      {required this.studentID, required this.token});
}

@immutable
class UpdateUndergraduateDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;
  final UndergraduateDetails undergraduateDetails;
  const UpdateUndergraduateDetailsEvent(
      {required this.studentID,
      required this.undergraduateDetails,
      required this.token});
}
