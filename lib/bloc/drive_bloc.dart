import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../models/company.dart';
import '../dummy_data/companies.dart' show companies;
import '../widgets/drives_screen/filter_functions.dart';
import 'drive_events.dart';
import 'drive_states.dart';

DateTime convertToFlutterDateTime(String jsDateString) {
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

      final http.Response resp1 = await http.get(
          Uri.parse("$registerForDriveURL?type=user&id=${event.studentID}"),
          headers: {"Authorization": event.token});

      if (resp.statusCode == 200 && resp1.statusCode == 200) {
        var jsonBody = jsonDecode(resp1.body);
        var jsonBodyData = jsonBody['drives'];

        final Set<int> registeredCompaniesIDs = {};
        for (var drive in jsonBodyData) {
          registeredCompaniesIDs.add(drive['drive_id'] ?? 0);
        }

        jsonBody = jsonDecode(resp.body);
        jsonBodyData = jsonBody['drives'];
        companies.clear();

        Set<Company> fetchedCompanies = {};

        for (var drive in jsonBodyData) {
          final dateOfDrive = convertToFlutterDateTime(drive['date_of_drive']);
          final currentDate = DateTime.now();
          fetchedCompanies.add(Company(
              name: drive['company_name'],
              companyID: drive['id'] ?? 0,
              driveType: drive['type_of_drive'],
              timeLeft: convertToFlutterDateTime(drive['closes_at'])
                  .difference(currentDate)
                  .inDays,
              imageURL: 'imageURL',
              startedAtTime: currentDate
                  .difference(convertToFlutterDateTime(drive['created_at']))
                  .inDays,
              details: drive['company_about'],
              eligibilityCriteria: drive['other_eligibility_criteria'],
              dateOfDrive:
                  "${dateOfDrive.day.toString().padLeft(2, '0')}/${dateOfDrive.month.toString().padLeft(2, '0')}/${dateOfDrive.year}",
              jobProfile: drive['job_profile'],
              location: drive['job_location'],
              package: drive['pay_package'],
              bond: drive['bond'],
              roles: (drive['positions'] as List<dynamic>)
                  .map((position) => position
                      .toString()
                      .split(RegExp(r"(?<=[a-z])(?=[A-Z])"))
                      .fold(
                          "",
                          (previousValue, element) => previousValue.isEmpty
                              ? element
                              : "$previousValue $element"))
                  .toList(),
              process: [drive['placement_process']],
              numRegistrations: drive['_count']['participants'],
              hasRegistered:
                  registeredCompaniesIDs.contains(drive['id'] ?? 0)));
        }

        companies.addAll(
          FilterFunctions.sortCompanies(
              companies: fetchedCompanies,
              sortCriteria: FilterFunctions.sortByField),
        );
        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(
                const FetchedDrivesState(isLoading: false, authError: null)));
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
