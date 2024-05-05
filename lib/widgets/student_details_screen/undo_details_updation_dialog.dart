import 'package:flutter/material.dart';

class UndoDetailsUpdationDialog extends StatelessWidget {
  const UndoDetailsUpdationDialog({
    super.key,
    required this.onUndo,
  });

  final Function() onUndo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Action"),
      content: const Text(
          "Do you want to undo all changes? All unsaved changes would be lost!"),
      actions: [
        TextButton(
            onPressed: () => {onUndo(), Navigator.of(context).pop()},
            child: const Text("Yes")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"))
      ],
    );
  }
}
