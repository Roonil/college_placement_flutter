import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/intermediate_school_details.dart';

@immutable
abstract class IntermediateSchoolDetailsState {
  final bool isLoading;
  final Exception? authError;

  const IntermediateSchoolDetailsState(
      {required this.isLoading, required this.authError});
}

@immutable
class InitialState extends IntermediateSchoolDetailsState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingIntermediateSchoolDetailsState extends InitialState {
  const FetchingIntermediateSchoolDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class IntermediateSchoolDetailsFetchFailedState extends InitialState {
  const IntermediateSchoolDetailsFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedIntermediateSchoolDetailsState extends InitialState {
  final IntermediateSchoolDetails intermediateSchoolDetails;
  const FetchedIntermediateSchoolDetailsState(
      {required this.intermediateSchoolDetails,
      required super.isLoading,
      required super.authError});
}

@immutable
class UpdatingIntermediateSchoolDetailsState extends InitialState {
  const UpdatingIntermediateSchoolDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class IntermediateSchoolDetailsUpdateFailedState extends InitialState {
  const IntermediateSchoolDetailsUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedIntermediateSchoolDetailsState extends InitialState {
  final IntermediateSchoolDetails intermediateSchoolDetails;
  const UpdatedIntermediateSchoolDetailsState(
      {required this.intermediateSchoolDetails,
      required super.isLoading,
      required super.authError});
}
