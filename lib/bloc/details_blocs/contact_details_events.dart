import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/contact_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchContactDetailsEvent implements ContactDetailsEvent {
  final String token;
  final int studentID;
  const FetchContactDetailsEvent(
      {required this.studentID, required this.token});
}

@immutable
class UpdateContactDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final ContactDetails contactDetails;
  final String token;
  const UpdateContactDetailsEvent(
      {required this.studentID,
      required this.contactDetails,
      required this.token});
}
