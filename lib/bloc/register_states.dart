import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class RegisterState {
  final bool isLoading;

  final Exception? authError;

  const RegisterState({required this.isLoading, required this.authError});
}

class InitialState extends RegisterState {
  const InitialState({
    required super.isLoading,
    required super.authError,
  });
}

@immutable
class RegisteringDriveState extends InitialState {
  const RegisteringDriveState(
      {required super.isLoading, required super.authError});
}

@immutable
class DriveRegisterFailedState extends InitialState {
  const DriveRegisterFailedState(
      {required super.isLoading, required super.authError});
}

@immutable
class RegisteredDriveState extends InitialState {
  const RegisteredDriveState(
      {required super.isLoading, required super.authError});
}
