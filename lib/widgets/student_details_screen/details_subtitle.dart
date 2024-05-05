import 'package:flutter/material.dart';

import 'confirm_details_updation_dialog.dart';
import 'undo_details_updation_dialog.dart';

class DetailsSubtitle extends StatelessWidget {
  const DetailsSubtitle(
      {super.key,
      required this.hasFetched,
      required this.shouldShowButtons,
      required this.hasUpdated,
      required this.isFetching,
      required this.isUpdating,
      required this.isEdited,
      required this.onSaved,
      required this.onUndo});
  final bool isFetching,
      isUpdating,
      hasFetched,
      hasUpdated,
      isEdited,
      shouldShowButtons;

  final Function() onSaved, onUndo;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  isFetching || isUpdating
                      ? Icons.timer
                      : isEdited
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle,
                  color: isEdited || isFetching || isUpdating
                      ? Colors.amber
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
              Flexible(
                child: Text(isFetching
                    ? "Fetching Details"
                    : isUpdating
                        ? "Updating Details"
                        : isEdited
                            ? "Pending Changes"
                            : "Details Up-to-Date"),
              )
            ],
          ),
        ),
        (hasFetched || hasUpdated) && shouldShowButtons && isEdited
            ? Wrap(
                children: [
                  IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            UndoDetailsUpdationDialog(onUndo: onUndo)),
                    icon: const Icon(
                      Icons.undo,
                      color: Colors.red,
                    ),
                    tooltip: "Undo Changes",
                  ),
                  IconButton(
                      onPressed: () => showDialog(
                            context: context,
                            builder: (context) =>
                                ConfirmDetailsUpdationDialog(onSaved: onSaved),
                          ),
                      tooltip: "Save Changes",
                      icon: Icon(
                        Icons.save,
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
                ],
              )
            : const SizedBox()
      ],
    );
  }
}
