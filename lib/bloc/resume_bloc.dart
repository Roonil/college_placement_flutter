import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MediaType;
import '../constants.dart';
import 'resume_events.dart';
import 'resume_states.dart';

class ResumeBloc extends Bloc<ResumeEvent, ResumeState> {
  ResumeBloc() : super(const InitialState(isLoading: false, authError: null)) {
    on<FetchResumesEvent>(_fetchResumes);
    on<UpdateResumeEvent>(_updateResume);
  }

  Future<FutureOr<void>> _fetchResumes(
      FetchResumesEvent event, Emitter<ResumeState> emit) async {
    emit(const FetchingResumesState(isLoading: true, authError: null));
    final Map<String, dynamic> resumes = {};

    try {
      http.Response resp = await http
          .get(Uri.parse("${hostName}S-${event.studentID}-resume1.pdf"))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      if (resp.statusCode == 200) {
        resumes['resume_1'] = resp.body;
      }

      resp = await http
          .get(Uri.parse("${hostName}S-${event.studentID}-resume2.pdf"))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      if (resp.statusCode == 200) {
        resumes['resume_2'] = resp.body;
      }

      resp = await http
          .get(Uri.parse("${hostName}S-${event.studentID}-resume3.pdf"))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => http.Response('Error', 408),
          );

      if (resp.statusCode == 200) {
        resumes['resume_3'] = resp.body;
      }

      emit(FetchedResumesState(
          isLoading: false, resumes: resumes, authError: null));
    } catch (_) {
      emit(const ResumesFetchFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }

  Future<FutureOr<void>> _updateResume(
      UpdateResumeEvent event, Emitter<ResumeState> emit) async {
    emit(const UpdatingResumeState(isLoading: true, authError: null));
    try {
      final uri = Uri.parse("$patchDetailsURL?type=id&id=${event.studentID}");
      var request = http.MultipartRequest('PATCH', uri);
      final resumeFile = http.MultipartFile.fromBytes(
          event.resumeName, event.resumeBytes!,
          contentType: MediaType.parse('application/pdf'),
          filename: '${event.resumeName}.pdf');

      request.files.add(resumeFile);
      request.headers['Authorization'] = event.token;

      final resp = await request.send().timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                http.StreamedResponse(Stream.value(utf8.encode('Error')), 408),
          );

      if (resp.statusCode == 200) {
        event.resumes[event.resumeName] = event.resumeBytes!;
        await Future.delayed(const Duration(seconds: 0, milliseconds: 500))
            .then((_) => emit(UpdatedResumeState(
                isLoading: false, resumes: event.resumes, authError: null)));
      } else {
        emit(const ResumeUpdateFailedState(
            isLoading: false, authError: HttpException("Fetching Failed!")));
      }
    } catch (_) {
      emit(const ResumeUpdateFailedState(
          isLoading: false, authError: HttpException("An Error occured!")));
    }
  }
}
