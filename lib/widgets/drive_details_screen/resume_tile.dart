import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/login_bloc.dart';
import '../../bloc/login_bloc_states.dart';
import '../../bloc/resume_bloc.dart';
import '../../bloc/resume_events.dart';
import '../../bloc/resume_states.dart';

class ResumeTile extends StatefulWidget {
  final String? name;
  final int currentValue, groupValue;
  final Uri? uri;
  final Function(int?) onChanged;
  const ResumeTile(
      {super.key,
      required this.name,
      required this.currentValue,
      required this.uri,
      required this.groupValue,
      required this.onChanged});

  @override
  State<ResumeTile> createState() => _ResumeTileState();
}

class _ResumeTileState extends State<ResumeTile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResumeBloc, ResumeState>(
        listener: (context, state) {},
        buildWhen: (previous, current) =>
            previous is UpdatingResumeState && current is UpdatedResumeState,
        builder: (context, state) {
          return Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: widget.name == null
                        ? Radio(
                            value: widget.currentValue,
                            groupValue: widget.groupValue,
                            onChanged: null,
                          )
                        : Radio(
                            value: widget.currentValue,
                            groupValue: widget.groupValue,
                            onChanged: (value) => widget.onChanged(value),
                          ),
                  ),
                  Flexible(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.file_present,
                                    color: widget.name == null ||
                                            state is FetchingResumesState ||
                                            state is UpdatingResumeState
                                        ? Theme.of(context).disabledColor
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: widget.uri == null
                                          ? null
                                          : () async {
                                              if (!await launchUrl(
                                                  widget.uri!)) {
                                                throw Exception(
                                                    'Could not launch $widget.uri!');
                                              }
                                            },
                                      child: Text(
                                        widget.name ?? "No File Selected!",
                                        style: TextStyle(
                                            color: state
                                                        is FetchingResumesState ||
                                                    state is UpdatingResumeState
                                                ? Theme.of(context)
                                                    .disabledColor
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: IconButton(
                                      onPressed:
                                          state is FetchingResumesState ||
                                                  state is UpdatingResumeState
                                              ? null
                                              : () {
                                                  FilePicker.platform.pickFiles(
                                                      allowMultiple: false,
                                                      type: FileType.custom,
                                                      withData: true,
                                                      allowedExtensions: [
                                                        'pdf'
                                                      ]).then((resume) => resume !=
                                                          null
                                                      ? BlocProvider.of<ResumeBloc>(context).add(
                                                          UpdateResumeEvent(
                                                              resumeName:
                                                                  "resume_${widget.currentValue}",
                                                              studentID: (BlocProvider.of<LoginBloc>(context)
                                                                          .state
                                                                      as LoggedInState)
                                                                  .student
                                                                  .id,
                                                              resumes: state
                                                                      is FetchedResumesState
                                                                  ? state.resumes
                                                                  : state is UpdatedResumeState
                                                                      ? state.resumes
                                                                      : {},
                                                              resumeBytes: resume.files[0].bytes,
                                                              token: (BlocProvider.of<LoginBloc>(context).state as LoggedInState).student.token))
                                                      : null);
                                                },
                                      tooltip: "Upload/Update Resume",
                                      icon: const Icon(
                                          Icons.cloud_upload_outlined),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
