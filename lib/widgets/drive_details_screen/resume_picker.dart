import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';
import '../../bloc/login_bloc_states.dart';
import '../../bloc/resume_bloc.dart';
import '../../bloc/resume_events.dart';
import '../../bloc/resume_states.dart';

import 'package:flutter/material.dart';

import 'resume_tile.dart';

class ResumePicker extends StatefulWidget {
  final int groupValue;
  final Function(int) onChanged;

  const ResumePicker(
      {super.key, required this.groupValue, required this.onChanged});

  @override
  State<ResumePicker> createState() => _ResumePickerState();
}

class _ResumePickerState extends State<ResumePicker> {
  int? groupValue;
  final Map<String, String> resumes = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {
          state is FetchedResumesState
              ? resumes.addAll(state.resumes)
              : state is UpdatedResumeState
                  ? resumes.addAll(state.resumes)
                  : null;
        },
        listenWhen: (previous, current) =>
            (previous is FetchingResumesState &&
                current is FetchedResumesState) ||
            (previous is UpdatingResumeState && current is UpdatedResumeState),
        buildWhen: (previous, current) =>
            (previous is FetchingResumesState &&
                current is FetchedResumesState) ||
            (previous is UpdatingResumeState &&
                current is UpdatedResumeState) ||
            current is UpdatingResumeState ||
            current is FetchingResumesState,
        builder: (context, state) {
          state is FetchedResumesState
              ? resumes.addAll(state.resumes)
              : state is UpdatedResumeState
                  ? resumes.addAll(state.resumes)
                  : null;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: state is FetchingResumesState ||
                            state is UpdatingResumeState
                        ? null
                        : () => BlocProvider.of<ResumeBloc>(context).add(
                            FetchResumesEvent(
                                studentID: (BlocProvider.of<LoginBloc>(context)
                                        .state as LoggedInState)
                                    .student
                                    .id)),
                    tooltip: "Refresh Resumes",
                    icon: const Icon(Icons.refresh)),
                ResumeTile(
                    name: resumes['resume1'] != null ? "Resume1.pdf" : null,
                    uri: resumes['resume1'] != null
                        ? Uri.parse(resumes['resume1']!)
                        : null,
                    currentValue: 1,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 1;
                          widget.onChanged(value ?? 1);
                        })),
                ResumeTile(
                    name: resumes['resume2'] != null ? "Resume2.pdf" : null,
                    uri: resumes['resume2'] != null
                        ? Uri.parse(resumes['resume2']!)
                        : null,
                    currentValue: 2,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 2;
                          widget.onChanged(value ?? 2);
                        })),
                ResumeTile(
                    name: resumes['resume3'] != null ? "Resume3.pdf" : null,
                    uri: resumes['resume3'] != null
                        ? Uri.parse(resumes['resume3']!)
                        : null,
                    currentValue: 3,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 3;
                          widget.onChanged(value ?? 3);
                        })),
              ],
            ),
          );
        });
  }
}
