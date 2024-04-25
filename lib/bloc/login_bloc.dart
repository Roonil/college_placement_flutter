import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/student.dart';
import 'login_bloc_states.dart';
import 'login_events.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoggedOutState(isLoading: false, authError: null)) {
    on<InitiateLoginEvent>(_login);
    on<LogoutEvent>(_logout);
  }
  FutureOr<void> _login(
      InitiateLoginEvent event, Emitter<LoginState> emit) async {
    emit(const LoggingInState(isLoading: true, authError: null));

    try {
      final http.Response resp = await http.post(Uri.parse(loginURL),
          body: jsonEncode({
            "university_email": event.universityEmail,
            "password": event.password
          }),
          headers: {"Content-Type": "application/json"}).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('Error', 408),
      );

      final jsonBody = jsonDecode(resp.body);

      final jsonBodyData = jsonBody['data'];

      if (resp.statusCode == 200) {
        emit(LoggedInState(
            student: Student(
                firstName: jsonBodyData['first_name'],
                id: jsonBodyData['id'],
                lastName: jsonBodyData['last_name'],
                uID: jsonBodyData['uid'],
                universityEmail: jsonBodyData['university_email'],
                token: jsonBody['token']),
            isLoading: false,
            authError: null));
      } else {
        emit(const LoginFailedState(
            isLoading: false, authError: HttpException("Login Failed!")));
      }
    } catch (_) {
      emit(const LoginFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<LoginState> emit) {}
}
