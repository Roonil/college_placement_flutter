import 'dart:math';

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

    for (int idx = 0; idx < min(2, roles.length); idx++) {
      final String role = roles[idx];
      rowChildren.add(Flexible(
        child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: selectedIdx != null
                ? FilterChip.elevated(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    checkmarkColor: Theme.of(context).colorScheme.onBackground,
                    onSelected: (value) => onTap!(idx),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    elevation: 4,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    label: Text(
                      role,
                    ),
                    selected: selectedIdx == idx)
                : Chip(
                    label: Text(role),
                  )),
      ));
    }

    if (roles.length > 2) {
      rowChildren.add(Flexible(child: Text("+${roles.length - 2} more")));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: rowChildren);
  }
}
