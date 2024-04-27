import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

@immutable
class ApplyToDriveEvent implements RegisterEvent {
  final int studentID, driveID, selectedResume;
  final String selectedRole, token;

  const ApplyToDriveEvent(
      {required this.studentID,
      required this.driveID,
      required this.token,
      required this.selectedResume,
      required this.selectedRole});
}
