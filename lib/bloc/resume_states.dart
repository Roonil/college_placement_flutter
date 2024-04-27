import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class ResumeState {
  final bool isLoading;
  final Exception? authError;

  const ResumeState({required this.isLoading, required this.authError});
}

@immutable
class InitialState extends ResumeState {
  const InitialState({required super.isLoading, required super.authError});
}

@immutable
class FetchingResumesState extends InitialState {
  const FetchingResumesState(
      {required super.isLoading, required super.authError});
}

@immutable
class ResumesFetchFailedState extends InitialState {
  const ResumesFetchFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class FetchedResumesState extends InitialState {
  final Map<String, dynamic> resumes;
  const FetchedResumesState(
      {required super.isLoading,
      required super.authError,
      required this.resumes});
}

@immutable
class UpdatingResumeState extends InitialState {
  const UpdatingResumeState(
      {required super.isLoading, required super.authError});
}

@immutable
class ResumeUpdateFailedState extends InitialState {
  const ResumeUpdateFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class UpdatedResumeState extends InitialState {
  final Map<String, dynamic> resumes;
  const UpdatedResumeState(
      {required super.isLoading,
      required this.resumes,
      required super.authError});
}
