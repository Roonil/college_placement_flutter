import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<ApplyToDriveEvent>(_applyToDrive);
  }

  Future<FutureOr<void>> _applyToDrive(
      ApplyToDriveEvent event, Emitter<RegisterState> emit) async {
    emit(const RegisteringDriveState(isLoading: true, authError: null));

    //TODO: Add API Calls
    try {
      final http.Response resp = await http
          .post(Uri.parse(registerForDriveURL),
              headers: {
                "Authorization": event.token,
                "Content-Type": "application/json"
              },
              body: jsonEncode({
                "student_id": event.studentID,
                "drive_id": event.driveID,
                "selected_position": event.selectedRole,
                "selected_resume": event.selectedResume.toString()
              }))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      if (resp.statusCode == 200) {
        await Future.delayed(const Duration(milliseconds: 500)).then((value) =>
            emit(
                const RegisteredDriveState(isLoading: false, authError: null)));
      } else {
        emit(const DriveRegisterFailedState(
            isLoading: false,
            authError: HttpException("Registration Failed!")));
      }
    } catch (e) {
      print(e);
      emit(const DriveRegisterFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }

    // await Future.delayed(const Duration(seconds: 2)).then((value) =>
    //     emit(const RegisteredDriveState(isLoading: false, authError: null)));
  }
}
