import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 5)).then((_) => emit(
        FetchedUndergraduateDetailsState(
            undergraduateDetails: UndergraduateDetails(
                university: "Chandigarh University",
                universityId: "20BCSXXXX",
                universityEmail: "20BCSXXXX@cuchd.in",
                degree: "BE/BTech",
                course: "CSE",
                currentCgpa: "8.0",
                batch: "202X",
                backlogs: "0"),
            isLoading: false,
            authError: null)));
  }

  Future<FutureOr<void>> _updateUndergraduateDetails(
      UpdateUndergraduateDetailsEvent event,
      Emitter<UndergraduateDetailsState> emit) async {
    emit(const UpdatingUndergraduateDetailsState(
        isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        UpdatedUndergraduateDetailsState(
            undergraduateDetails: UndergraduateDetails(
                university: "Chandigarh University",
                universityId: "20BCSXXXX",
                universityEmail: "20BCSXXXX@cuchd.in",
                degree: "BE/BTech",
                course: "CSE",
                currentCgpa: "8.0",
                batch: "202X",
                backlogs: "0"),
            isLoading: false,
            authError: null)));
  }
}
