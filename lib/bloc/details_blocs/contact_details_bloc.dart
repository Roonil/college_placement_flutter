import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../../models/contact_details.dart';
import 'contact_details_events.dart';
import 'contact_details_states.dart';

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
            .then((_) => emit(FetchedContactDetailsState(
                contactDetails: ContactDetails(
                  currentAddress: jsonBodyData['current_address'] ?? "",
                  permanentAddress: jsonBodyData['permanent_address'] ?? "",
                  emailAddress: jsonBodyData['personal_email'] ?? "",
                  phoneNumber: jsonBodyData['contact_number'] ?? "",
                ),
                isLoading: false,
                authError: null)));
      } else {
        emit(const ContactDetailsFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const ContactDetailsFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updateContactDetails(UpdateContactDetailsEvent event,
      Emitter<ContactDetailsState> emit) async {
    emit(const UpdatingContactDetailsState(isLoading: true, authError: null));

    final body = <String, dynamic>{};

    body['personal_email'] = event.contactDetails.emailAddress;
    body['contact_number'] = event.contactDetails.phoneNumber;
    body['current_address'] = event.contactDetails.currentAddress;
    body['permanent_address'] = event.contactDetails.permanentAddress;

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
            .then((_) => emit(UpdatedContactDetailsState(
                contactDetails: event.contactDetails,
                isLoading: false,
                authError: null)));
      } else {
        emit(const ContactDetailsUpdateFailedState(
            isLoading: false, authError: HttpException("Updating Failed!")));
      }
    } catch (_) {
      emit(const ContactDetailsUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
