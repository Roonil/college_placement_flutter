import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../models/student.dart';

@immutable
abstract class LoginState {
  final bool isLoading;
  final Exception? authError;

  const LoginState({required this.isLoading, required this.authError});
}

@immutable
class LoggingInState extends LoginState {
  const LoggingInState({
    required super.isLoading,
    required super.authError,
  });
}

@immutable
class LoggedInState extends LoginState {
  final Student student;
  const LoggedInState(
      {required super.isLoading,
      required super.authError,
      required this.student});
}

class LoginFailedState extends LoginState {
  const LoginFailedState({
    required super.isLoading,
    required super.authError,
  });
}

@immutable
class LoggingOutState extends LoginState {
  const LoggingOutState({required super.isLoading, required super.authError});
}

@immutable
class LoggedOutState extends LoginState {
  const LoggedOutState({required super.isLoading, required super.authError});
}

@immutable
class LogoutFailedState extends LoginState {
  const LogoutFailedState({required super.isLoading, required super.authError});
}
