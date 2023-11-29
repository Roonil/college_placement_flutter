import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_details.dart';
import './contact_details_events.dart';
import './contact_details_states.dart';

class ContactDetailsBloc
    extends Bloc<ContactDetailsEvent, ContactDetailsState> {
  ContactDetailsBloc()
      : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchContactDetailsEvent>(_fetchContactDetails);

    on<UpdateContactDetailsEvent>(_updateContactDetails);
  }

  Future<FutureOr<void>> _fetchContactDetails(
      FetchContactDetailsEvent event, Emitter<ContactDetailsState> emit) async {
    emit(const FetchingContactDetailsState(isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        FetchedContactDetailsState(
            contactDetails: ContactDetails(
                addressLine1: "AD1",
                addressLine2: "AD2",
                city: "city",
                country: "cn",
                emailAddress: "anan@gmail.com",
                phoneNumber: "1234567890",
                pinCode: "335001",
                state: "S"),
            isLoading: false,
            authError: null)));
  }

  Future<FutureOr<void>> _updateContactDetails(UpdateContactDetailsEvent event,
      Emitter<ContactDetailsState> emit) async {
    emit(const UpdatingContactDetailsState(isLoading: true, authError: null));

    //TODO: Add API Calls

    await Future.delayed(const Duration(seconds: 2)).then((_) => emit(
        UpdatedContactDetailsState(
            contactDetails: ContactDetails(
                addressLine1: "Updated AD1",
                addressLine2: "Updated AD2",
                city: "UPD city",
                country: "UPD cn",
                emailAddress: "upd_anan@gmail.com",
                phoneNumber: "1234567890",
                pinCode: "335001",
                state: "updS"),
            isLoading: false,
            authError: null)));
  }
}
