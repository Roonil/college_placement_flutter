import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/undergraduate_details.dart';

@immutable
abstract class UndergraduateDetailsState {
  final bool isLoading;
  final Exception? authError;

  const UndergraduateDetailsState(
      {required this.isLoading, required this.authError});
}

@immutable
class InitialState extends UndergraduateDetailsState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingUndergraduateDetailsState extends InitialState {
  const FetchingUndergraduateDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class UndergraduateDetailsFetchFailedState extends InitialState {
  const UndergraduateDetailsFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedUndergraduateDetailsState extends InitialState {
  final UndergraduateDetails undergraduateDetails;
  const FetchedUndergraduateDetailsState(
      {required this.undergraduateDetails,
      required super.isLoading,
      required super.authError});
}

@immutable
class UpdatingUndergraduateDetailsState extends InitialState {
  const UpdatingUndergraduateDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class UndergraduateDetailsUpdateFailedState extends InitialState {
  const UndergraduateDetailsUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedUndergraduateDetailsState extends InitialState {
  final UndergraduateDetails undergraduateDetails;
  const UpdatedUndergraduateDetailsState(
      {required this.undergraduateDetails,
      required super.isLoading,
      required super.authError});
}
