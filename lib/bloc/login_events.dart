import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

@immutable
class InitiateLoginEvent implements LoginEvent {
  final String universityEmail, password;

  const InitiateLoginEvent(
      {required this.universityEmail, required this.password});
}

@immutable
class LogoutEvent implements LoginEvent {
  const LogoutEvent();
}
