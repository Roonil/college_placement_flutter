import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/metric_school_details.dart';

@immutable
abstract class MetricSchoolDetailsState {
  final bool isLoading;
  final Exception? authError;

  const MetricSchoolDetailsState(
      {required this.isLoading, required this.authError});
}

@immutable
class InitialState extends MetricSchoolDetailsState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingMetricSchoolDetailsState extends InitialState {
  const FetchingMetricSchoolDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class MetricSchoolDetailsFetchFailedState extends InitialState {
  const MetricSchoolDetailsFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedMetricSchoolDetailsState extends InitialState {
  final MetricSchoolDetails metricSchoolDetails;
  const FetchedMetricSchoolDetailsState(
      {required this.metricSchoolDetails,
      required super.isLoading,
      required super.authError});
}

@immutable
class UpdatingMetricSchoolDetailsState extends InitialState {
  const UpdatingMetricSchoolDetailsState(
      {required super.isLoading, required super.authError});
}

@immutable
class MetricSchoolDetailsUpdateFailedState extends InitialState {
  const MetricSchoolDetailsUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedMetricSchoolDetailsState extends InitialState {
  final MetricSchoolDetails metricSchoolDetails;
  const UpdatedMetricSchoolDetailsState(
      {required this.metricSchoolDetails,
      required super.isLoading,
      required super.authError});
}
