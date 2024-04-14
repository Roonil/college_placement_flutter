import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/undergraduate_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchUndergraduateDetailsEvent implements ContactDetailsEvent {
  final String studentID;

  const FetchUndergraduateDetailsEvent({required this.studentID});
}

@immutable
class UpdateUndergraduateDetailsEvent implements ContactDetailsEvent {
  final String studentID;
  final UndergraduateDetails undergraduateDetails;
  const UpdateUndergraduateDetailsEvent(
      {required this.studentID, required this.undergraduateDetails});
}
