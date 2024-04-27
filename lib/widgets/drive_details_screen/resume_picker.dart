import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/resume_bloc.dart';
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
  final Map<String, dynamic> resumes = {};

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
            (previous is UpdatingResumeState && current is UpdatedResumeState),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeTile(
                    name: resumes['resume_1'] != null ? "Resume1.pdf" : null,
                    currentValue: 1,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 1;
                          widget.onChanged(value ?? 1);
                        })),
                ResumeTile(
                    name: resumes['resume_2'] != null ? "Resume2.pdf" : null,
                    currentValue: 2,
                    groupValue: groupValue ?? widget.groupValue,
                    onChanged: (value) => setState(() {
                          groupValue = value ?? 2;
                          widget.onChanged(value ?? 2);
                        })),
                ResumeTile(
                    name: resumes['resume_3'] != null ? "Resume3.pdf" : null,
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
