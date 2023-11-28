import 'package:flutter/material.dart';

class RolesChipBuilder extends StatelessWidget {
  final List<String> roles;

  const RolesChipBuilder({
    super.key,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    final List<Flexible> rowChildren = [];
    for (String role in roles) {
      rowChildren.add(Flexible(
        child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Chip(label: Text(role))),
      ));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: rowChildren);
  }
}
