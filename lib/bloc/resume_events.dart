import 'dart:typed_data';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class ResumeEvent {
  const ResumeEvent();
}

@immutable
class FetchResumesEvent implements ResumeEvent {
  final int studentID;
  const FetchResumesEvent({required this.studentID});
}

@immutable
class UpdateResumeEvent implements ResumeEvent {
  final int studentID;
  final String token, resumeName;
  final Map<String, String> resumes;
  final Uint8List? resumeBytes;
  const UpdateResumeEvent(
      {required this.studentID,
      required this.resumeName,
      required this.resumes,
      required this.resumeBytes,
      required this.token});
}
