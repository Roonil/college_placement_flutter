import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class DriveEvent {
  const DriveEvent();
}

@immutable
class FetchDrivesEvent implements DriveEvent {
  final int? driveID;

  const FetchDrivesEvent({
    required this.driveID,
  });
}
