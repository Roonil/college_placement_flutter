import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 5)).then((_) => emit(
        FetchedIntermediateSchoolDetailsState(
            intermediateSchoolDetails: IntermediateSchoolDetails(
                schoolName: "APS",
                board: "CBSE",
                schoolCity: "kkr",
                passingYear: "2020",
                percentageScore: "99",
                medium: "English"),
            isLoading: false,
            authError: null)));
  }

  Future<FutureOr<void>> _updateIntermediateSchoolDetails(
      UpdateIntermediateSchoolDetailsEvent event,
      Emitter<IntermediateSchoolDetailsState> emit) async {
    emit(const UpdatingIntermediateSchoolDetailsState(
        isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        UpdatedIntermediateSchoolDetailsState(
            intermediateSchoolDetails: IntermediateSchoolDetails(
                schoolName: "APS",
                board: "CBSE",
                schoolCity: "kkr",
                passingYear: "2020",
                percentageScore: "99",
                medium: "English"),
            isLoading: false,
            authError: null)));
  }
}
