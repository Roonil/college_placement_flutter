import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 5)).then((_) => emit(
        FetchedMetricSchoolDetailsState(
            metricSchoolDetails: MetricSchoolDetails(
                schoolName: "APS",
                board: "CBSE",
                schoolCity: "kkr",
                passingYear: "2018",
                percentageScore: "99",
                medium: "English"),
            isLoading: false,
            authError: null)));
  }

  Future<FutureOr<void>> _updateMetricSchoolDetails(
      UpdateMetricSchoolDetailsEvent event,
      Emitter<MetricSchoolDetailsState> emit) async {
    emit(const UpdatingMetricSchoolDetailsState(
        isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        UpdatedMetricSchoolDetailsState(
            metricSchoolDetails: MetricSchoolDetails(
                schoolName: "APS",
                board: "CBSE",
                schoolCity: "kkr",
                passingYear: "2018",
                percentageScore: "99",
                medium: "English"),
            isLoading: false,
            authError: null)));
  }
}
