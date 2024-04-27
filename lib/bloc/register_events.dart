import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

@immutable
class ApplyToDriveEvent implements RegisterEvent {
  const ApplyToDriveEvent();
}
