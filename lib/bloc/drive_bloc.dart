import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../models/company.dart';
import '../dummy_data/companies.dart' show companies;
import 'drive_events.dart';
import 'drive_states.dart';

DateTime convertToFlutterDateTime(String jsDateString) {
  // Parse the date string using the JavaScript-like format
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ", 'en_US');
  DateTime parsedDate = dateFormat.parse(jsDateString);
  return parsedDate;
}

class DriveBloc extends Bloc<DriveEvent, DriveState> {
  DriveBloc() : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchDrivesEvent>(_fetchDrives);
  }
  Future<FutureOr<void>> _fetchDrives(
      FetchDrivesEvent event, Emitter<DriveState> emit) async {
    emit(const FetchingDrivesState(isLoading: true, authError: null));

    try {
      final http.Response resp = await http
          .get(
            Uri.parse("$getDrivesURL?id=${event.driveID ?? "all"}"),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      final jsonBody = jsonDecode(resp.body);
      final jsonBodyData = jsonBody['drives'];

      for (var drive in jsonBodyData) {
        final dateOfDrive = convertToFlutterDateTime(drive['date_of_drive']);
        final currentDate = DateTime.now();

        companies.add(Company(
            name: drive['company_name'],
            companyID: drive['id'].toString(),
            driveType: drive['type_of_drive'],
            timeLeft:
                "${convertToFlutterDateTime(drive['closes_at']).difference(currentDate).inDays}d",
            imageURL: 'imageURL',
            startedAtTime:
                "${currentDate.difference(convertToFlutterDateTime(drive['created_at'])).inDays}d",
            details: drive['company_about'],
            eligibilityCriteria: drive['other_eligibility_criteria'],
            dateOfDrive:
                "${dateOfDrive.day}/${dateOfDrive.month}/${dateOfDrive.year}",
            jobProfile: drive['job_profile'],
            location: drive['job_location'],
            package: drive['pay_package'],
            bond: drive['bond'],
            roles: (drive['positions'] as List<dynamic>)
                .map((position) => position.toString())
                .toList(),
            process: [drive['placement_process']],
            numRegistrations: 100,
            hasRegistered: false));

        //TODO:Fix hasRegistered and numRegistrations
      }
      if (resp.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(FetchedDrivesState(
                drives: companies, isLoading: false, authError: null)));
      } else {
        emit(const DrivesFetchFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const DrivesFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
