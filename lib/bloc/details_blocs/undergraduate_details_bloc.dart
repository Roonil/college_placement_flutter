import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/undergraduate_details.dart';
import 'undergraduate_details_events.dart';
import 'undergraduate_details_states.dart';

class UndergraduateDetailsBloc
    extends Bloc<ContactDetailsEvent, UndergraduateDetailsState> {
  UndergraduateDetailsBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchUndergraduateDetailsEvent>(_fetchUndergraduateDetails);
    on<UpdateUndergraduateDetailsEvent>(_updateUndergraduateDetails);
  }
  Future<FutureOr<void>> _fetchUndergraduateDetails(
      FetchUndergraduateDetailsEvent event,
      Emitter<UndergraduateDetailsState> emit) async {
    emit(const FetchingUndergraduateDetailsState(
        isLoading: true, authError: null));

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
            .then((_) => emit(FetchedUndergraduateDetailsState(
                undergraduateDetails: UndergraduateDetails(
                    backlogs: jsonBodyData['number_of_backlogs'] ?? 0,
                    batch: jsonBodyData['batch'].toString(),
                    course: jsonBodyData['course'] ?? "",
                    degree: jsonBodyData['stream'] ?? "",
                    currentCgpa: jsonBodyData['current_cgpa'].toString(),
                    university: "Chandigarh University",
                    universityEmail: jsonBodyData['university_email'] ?? "",
                    universityID: jsonBodyData['uid'] ?? ""),
                isLoading: false,
                authError: null)));
      } else {
        emit(const UndergraduateDetailsFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const UndergraduateDetailsFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updateUndergraduateDetails(
      UpdateUndergraduateDetailsEvent event,
      Emitter<UndergraduateDetailsState> emit) async {
    emit(const UpdatingUndergraduateDetailsState(
        isLoading: true, authError: null));

    final body = <String, dynamic>{};

    body['batch'] = event.undergraduateDetails.batch;
    body['stream'] = event.undergraduateDetails.degree;
    body['course'] = event.undergraduateDetails.course;
    body['current_cgpa'] = event.undergraduateDetails.currentCgpa.toString();

    body['university_email'] = event.undergraduateDetails.universityEmail;
    body['uid'] = event.undergraduateDetails.universityID;
    body['number_of_backlogs'] = event.undergraduateDetails.backlogs.toString();

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
            .then((_) => emit(UpdatedUndergraduateDetailsState(
                undergraduateDetails: event.undergraduateDetails,
                isLoading: false,
                authError: null)));
      } else {
        emit(const UndergraduateDetailsUpdateFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const UndergraduateDetailsUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
