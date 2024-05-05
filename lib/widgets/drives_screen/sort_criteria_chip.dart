import 'package:flutter/material.dart';

import 'filter_functions.dart';

class SortCriteriaChip extends StatelessWidget {
  final Function(bool) onSelected;
  final String criteria;
  const SortCriteriaChip(
      {super.key, required this.criteria, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip.elevated(
        side: BorderSide(
            width: 0,
            color: Theme.of(context).colorScheme.onBackground.withAlpha(120)),
        backgroundColor: Theme.of(context).colorScheme.background,
        labelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onBackground),
        // selected: FilterFunctions.sortByField == widget.criteria,
        showCheckmark: false,
        avatar: FilterFunctions.sortByField == criteria
            ? Icon(
                FilterFunctions.sortValue == 1
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: Theme.of(context).colorScheme.onBackground,
              )
            : null,
        label: Text(criteria),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        surfaceTintColor: Colors.white,
        onSelected: (value) => {
              FilterFunctions.sortByField == criteria
                  ? FilterFunctions.sortValue *= -1
                  : null,
              onSelected(value),
            });
  }
}
