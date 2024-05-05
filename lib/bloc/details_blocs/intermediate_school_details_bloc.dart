import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/intermediate_school_details.dart';
import 'intermediate_school_details_events.dart';
import 'intermediate_school_details_states.dart';

class IntermediateSchoolDetailsBloc
    extends Bloc<ContactDetailsEvent, IntermediateSchoolDetailsState> {
  IntermediateSchoolDetailsBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchIntermediateSchoolDetailsEvent>(_fetchIntermediateSchoolDetails);
    on<UpdateIntermediateSchoolDetailsEvent>(_updateIntermediateSchoolDetails);
  }
  Future<FutureOr<void>> _fetchIntermediateSchoolDetails(
      FetchIntermediateSchoolDetailsEvent event,
      Emitter<IntermediateSchoolDetailsState> emit) async {
    emit(const FetchingIntermediateSchoolDetailsState(
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
            .then((_) => emit(FetchedIntermediateSchoolDetailsState(
                intermediateSchoolDetails: IntermediateSchoolDetails(
                    board: jsonBodyData['hsc_board'] ?? "",
                    percentageScore: double.parse(
                        (jsonBodyData['hsc_result'] ?? 0).toString()),
                    schoolCity: jsonBodyData['hsc_city'] ?? "",
                    schoolName: jsonBodyData['hsc_school_name'] ?? ""),
                isLoading: false,
                authError: null)));
      } else {
        emit(const IntermediateSchoolDetailsFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const IntermediateSchoolDetailsFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updateIntermediateSchoolDetails(
      UpdateIntermediateSchoolDetailsEvent event,
      Emitter<IntermediateSchoolDetailsState> emit) async {
    emit(const UpdatingIntermediateSchoolDetailsState(
        isLoading: true, authError: null));

    final body = <String, dynamic>{};

    body['hsc_board'] = event.intermediateSchoolDetails.board;
    body['hsc_city'] = event.intermediateSchoolDetails.schoolCity;
    body['hsc_school_name'] = event.intermediateSchoolDetails.schoolName;
    body['hsc_result'] =
        event.intermediateSchoolDetails.percentageScore.toString();

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
            .then((_) => emit(UpdatedIntermediateSchoolDetailsState(
                intermediateSchoolDetails: event.intermediateSchoolDetails,
                isLoading: false,
                authError: null)));
      } else {
        emit(const IntermediateSchoolDetailsUpdateFailedState(
            isLoading: false, authError: HttpException("Updating Failed!")));
      }
    } catch (_) {
      emit(const IntermediateSchoolDetailsUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
