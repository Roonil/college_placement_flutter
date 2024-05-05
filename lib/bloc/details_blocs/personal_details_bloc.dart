import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
        final DateTime dob =
            DateTime.parse(jsonBodyData['dob'] ?? DateTime.now().toString());

        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(FetchedPersonalDetailsState(
                personalDetails: PersonalDetails(
                    dateOfBirth:
                        '${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year}',
                    firstName: jsonBodyData['first_name'] ?? "",
                    lastName: jsonBodyData['last_name'] ?? "",
                    nationality: jsonBodyData['nationality'] ?? ""),
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

    final body = <String, dynamic>{};

    body['first_name'] = event.personalDetails.firstName;
    body['last_name'] = event.personalDetails.lastName;
    body['dob'] =
        "${DateFormat("dd/MM/yyyy").parse(event.personalDetails.dateOfBirth).toIso8601String()}Z";
    body['nationality'] = event.personalDetails.nationality;

    try {
      final http.Response resp = await http
          .patch(Uri.parse("$patchDetailsURL?type=id&id=${event.studentID}"),
              headers: {
                "Authorization": event.token,
              },
              body: body)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      if (resp.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(UpdatedPersonalDetailsState(
                personalDetails: event.personalDetails,
                isLoading: false,
                authError: null)));
      } else {
        emit(const PersonalDetailsUpdateFailedState(
            isLoading: false, authError: HttpException("Updating Failed!")));
      }
    } catch (_) {
      emit(const PersonalDetailsUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
