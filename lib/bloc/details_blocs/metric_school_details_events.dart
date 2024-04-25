import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/metric_school_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchMetricSchoolDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;

  const FetchMetricSchoolDetailsEvent(
      {required this.studentID, required this.token});
}

@immutable
class UpdateMetricSchoolDetailsEvent implements ContactDetailsEvent {
  final int studentID;
  final String token;
  final MetricSchoolDetails metricSchoolDetails;
  const UpdateMetricSchoolDetailsEvent(
      {required this.studentID,
      required this.metricSchoolDetails,
      required this.token});
}
