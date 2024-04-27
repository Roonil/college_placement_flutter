import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/metric_school_details.dart';
import 'metric_school_details_events.dart';
import 'metric_school_details_states.dart';

class MetricSchoolDetailsBloc
    extends Bloc<ContactDetailsEvent, MetricSchoolDetailsState> {
  MetricSchoolDetailsBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchMetricSchoolDetailsEvent>(_fetchMetricSchoolDetails);
    on<UpdateMetricSchoolDetailsEvent>(_updateMetricSchoolDetails);
  }
  Future<FutureOr<void>> _fetchMetricSchoolDetails(
      FetchMetricSchoolDetailsEvent event,
      Emitter<MetricSchoolDetailsState> emit) async {
    emit(const FetchingMetricSchoolDetailsState(
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
            .then((_) => emit(FetchedMetricSchoolDetailsState(
                metricSchoolDetails: MetricSchoolDetails(
                    board: jsonBodyData['matric_board'] ?? "",
                    percentageScore: jsonBodyData['matric_result'].toString(),
                    schoolCity: jsonBodyData['matric_city'] ?? "",
                    schoolName: jsonBodyData['matric_school_name'] ?? ""),
                isLoading: false,
                authError: null)));
      } else {
        emit(const MetricSchoolDetailsFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const MetricSchoolDetailsFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updateMetricSchoolDetails(
      UpdateMetricSchoolDetailsEvent event,
      Emitter<MetricSchoolDetailsState> emit) async {
    emit(const UpdatingMetricSchoolDetailsState(
        isLoading: true, authError: null));

    final body = <String, dynamic>{};

    body['matric_board'] = event.metricSchoolDetails.board;
    body['matric_city'] = event.metricSchoolDetails.schoolCity;
    body['matric_school_name'] = event.metricSchoolDetails.schoolName;
    body['matric_result'] =
        event.metricSchoolDetails.percentageScore.toString();

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
            .then((_) => emit(UpdatedMetricSchoolDetailsState(
                metricSchoolDetails: event.metricSchoolDetails,
                isLoading: false,
                authError: null)));
      } else {
        emit(const MetricSchoolDetailsUpdateFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const MetricSchoolDetailsUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
