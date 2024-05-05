import 'package:flutter/material.dart';

import 'filter_functions.dart';

class SearchCriteriaChip extends StatefulWidget {
  final String criteria;
  const SearchCriteriaChip({super.key, required this.criteria});

  @override
  State<SearchCriteriaChip> createState() => _SearchCriteriaChipState();
}

class _SearchCriteriaChipState extends State<SearchCriteriaChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip.elevated(
        side: BorderSide(
            width: 0,
            color: Theme.of(context).colorScheme.onBackground.withAlpha(120)),
        backgroundColor: Theme.of(context).colorScheme.background,
        labelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onBackground),
        selected: FilterFunctions.searchFields.contains(widget.criteria),
        label: Text(widget.criteria),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        onSelected: (value) => setState(() {
              value
                  ? FilterFunctions.searchFields.add(widget.criteria)
                  : FilterFunctions.searchFields.length > 1
                      ? FilterFunctions.searchFields.remove(widget.criteria)
                      : null;
            }));
  }
}
