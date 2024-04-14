import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../../models/metric_school_details.dart';

@immutable
abstract class ContactDetailsEvent {
  const ContactDetailsEvent();
}

@immutable
class FetchMetricSchoolDetailsEvent implements ContactDetailsEvent {
  final String studentID;

  const FetchMetricSchoolDetailsEvent({required this.studentID});
}

@immutable
class UpdateMetricSchoolDetailsEvent implements ContactDetailsEvent {
  final String studentID;
  final MetricSchoolDetails metricSchoolDetails;
  const UpdateMetricSchoolDetailsEvent(
      {required this.studentID, required this.metricSchoolDetails});
}
