import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../models/company.dart';

@immutable
abstract class DriveState {
  final bool isLoading;
  final Exception? authError;

  const DriveState({required this.isLoading, required this.authError});
}

@immutable
class InitialState extends DriveState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingDrivesState extends InitialState {
  const FetchingDrivesState(
      {required super.isLoading, required super.authError});
}

@immutable
class DrivesFetchFailedState extends InitialState {
  const DrivesFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedDrivesState extends InitialState {
  final Set<Company> drives;
  const FetchedDrivesState(
      {required this.drives,
      required super.isLoading,
      required super.authError});
}
