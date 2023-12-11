import 'package:flutter/material.dart';

import '../../dummy_data/filter_actions.dart';
import '../../models/filter.dart';
import './drive_filter_chip.dart';

class FilterBuilder extends StatelessWidget {
  const FilterBuilder({
    super.key,
    required this.filters,
    required this.onTap,
  });

  final Set<Filter> filters;
  final Function(FilterType) onTap;

  @override
  Widget build(BuildContext context) {
    final List<Padding> filterChips = [];

    for (Filter filter in filters) {
      filterChips.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: DriveFilterChip(filter: filter, onTap: onTap),
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: filterChips,
        ),
      ),
    );
  }
}
