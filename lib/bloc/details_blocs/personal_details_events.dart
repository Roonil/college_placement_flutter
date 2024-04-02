import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/personal_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchPersonalDetailsEvent implements ContactDetailsEvent {
  final String studentID;

  const FetchPersonalDetailsEvent({required this.studentID});
}

@immutable
class UpdatePersonalDetailsEvent implements ContactDetailsEvent {
  final String studentID;
  final PersonalDetails personalDetails;
  const UpdatePersonalDetailsEvent(
      {required this.studentID, required this.personalDetails});
}
