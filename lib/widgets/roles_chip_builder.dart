import 'package:flutter/material.dart';

class RolesChipBuilder extends StatelessWidget {
  final List<String> roles;
  final Function(int)? onTap;

  final int? selectedIdx;
  const RolesChipBuilder(
      {super.key,
      required this.roles,
      required this.onTap,
      required this.selectedIdx});

  @override
  Widget build(BuildContext context) {
    final List<Flexible> rowChildren = [];

    for (int idx = 0; idx < roles.length; idx++) {
      final String role = roles[idx];
      rowChildren.add(Flexible(
        child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: selectedIdx != null
                ? FilterChip.elevated(
                    onSelected: (value) => onTap!(idx),
                    checkmarkColor: Colors.white,
                    elevation: 4,
                    padding: EdgeInsets.zero,
                    label: Text(
                      role,
                    ),
                    selected: selectedIdx == idx)
                : Chip(
                    label: Text(role),
                  )),
      ));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: rowChildren);
  }
}
