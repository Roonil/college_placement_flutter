import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/personal_details.dart';

@immutable
abstract class PersonalDetailsState {
  final bool isLoading;
  final Exception? authError;

  const PersonalDetailsState(
      {required this.isLoading, required this.authError});
}

@immutable
class InitialState extends PersonalDetailsState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingPersonalDetailsState extends InitialState {
  const FetchingPersonalDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class PersonalDetailsFetchFailedState extends InitialState {
  const PersonalDetailsFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedPersonalDetailsState extends InitialState {
  final PersonalDetails personalDetails;
  const FetchedPersonalDetailsState(
      {required this.personalDetails,
      required super.isLoading,
      required super.authError});
}

@immutable
class UpdatingPersonalDetailsState extends InitialState {
  const UpdatingPersonalDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class PersonalDetailsUpdateFailedState extends InitialState {
  const PersonalDetailsUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedPersonalDetailsState extends InitialState {
  final PersonalDetails personalDetails;
  const UpdatedPersonalDetailsState(
      {required this.personalDetails,
      required super.isLoading,
      required super.authError});
}
