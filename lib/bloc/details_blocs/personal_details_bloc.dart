import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/personal_details.dart';
import 'personal_details_events.dart';
import 'personal_details_states.dart';

class PersonalDetailsBloc
    extends Bloc<ContactDetailsEvent, PersonalDetailsState> {
  PersonalDetailsBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchPersonalDetailsEvent>(_fetchPersonalDetails);
    on<UpdatePersonalDetailsEvent>(_updatePersonalDetails);
  }
  Future<FutureOr<void>> _fetchPersonalDetails(FetchPersonalDetailsEvent event,
      Emitter<PersonalDetailsState> emit) async {
    emit(const FetchingPersonalDetailsState(isLoading: true, authError: null));

    //TODO: Check response body

    try {
      final http.Response resp = await http.get(
          Uri.parse("$getDetailsURL?type=id&id=${event.studentID}"),
          headers: {
            "Authorization": event.token,
          }).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('Error', 408),
      );

      final jsonBody = jsonDecode(resp.body);
      final jsonBodyData = jsonBody['acc'];

      if (resp.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(FetchedPersonalDetailsState(
                personalDetails: PersonalDetails(
                    dateOfBirth: "17/12/2000",
                    firstName: jsonBodyData['first_name'],
                    lastName: jsonBodyData['last_name'],
                    nationality: "Indian"),
                isLoading: false,
                authError: null)));
      } else {
        emit(const PersonalDetailsFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const PersonalDetailsFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updatePersonalDetails(
      UpdatePersonalDetailsEvent event,
      Emitter<PersonalDetailsState> emit) async {
    emit(const UpdatingPersonalDetailsState(isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        UpdatedPersonalDetailsState(
            personalDetails: PersonalDetails(
                dateOfBirth: "17/12/2002",
                firstName: "Updated Anand",
                lastName: "Updated Verma",
                nationality: "Updated Indian"),
            isLoading: false,
            authError: null)));
  }
}
