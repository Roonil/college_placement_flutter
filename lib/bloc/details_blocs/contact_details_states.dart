import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/contact_details.dart';

@immutable
abstract class ContactDetailsState {
  final bool isLoading;
  final Exception? authError;

  const ContactDetailsState({required this.isLoading, required this.authError});
}

@immutable
class InitialState extends ContactDetailsState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingContactDetailsState extends InitialState {
  const FetchingContactDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class ContactDetailsFetchFailedState extends InitialState {
  const ContactDetailsFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedContactDetailsState extends InitialState {
  final ContactDetails contactDetails;
  const FetchedContactDetailsState(
      {required this.contactDetails,
      required super.isLoading,
      required super.authError});
}

@immutable
class UpdatingContactDetailsState extends InitialState {
  const UpdatingContactDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class ContactDetailsUpdateFailedState extends InitialState {
  const ContactDetailsUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedContactDetailsState extends InitialState {
  final ContactDetails contactDetails;
  const UpdatedContactDetailsState(
      {required this.contactDetails,
      required super.isLoading,
      required super.authError});
}
