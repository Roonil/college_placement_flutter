import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 5)).then((_) => emit(
        FetchedPersonalDetailsState(
            personalDetails: PersonalDetails(
                dateOfBirth: "17/12/2000",
                firstName: "Anand",
                lastName: "Verma",
                nationality: "Indian"),
            isLoading: false,
            authError: null)));
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
