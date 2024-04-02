import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/contact_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchContactDetailsEvent implements ContactDetailsEvent {
  final String studentID;

  const FetchContactDetailsEvent({required this.studentID});
}

@immutable
class UpdateContactDetailsEvent implements ContactDetailsEvent {
  final String studentID;
  final ContactDetails contactDetails;
  const UpdateContactDetailsEvent(
      {required this.studentID, required this.contactDetails});
}
