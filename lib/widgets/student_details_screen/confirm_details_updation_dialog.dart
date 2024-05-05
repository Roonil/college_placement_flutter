import 'package:flutter/material.dart';

class ConfirmDetailsUpdationDialog extends StatelessWidget {
  const ConfirmDetailsUpdationDialog({
    super.key,
    required this.onSaved,
  });

  final Function() onSaved;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Action"),
      content: const Text(
          "Do you want to save all changes and update them on the server?"),
      actions: [
        TextButton(
            onPressed: () => {onSaved(), Navigator.of(context).pop()},
            child: const Text("Yes")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"))
      ],
    );
  }
}
