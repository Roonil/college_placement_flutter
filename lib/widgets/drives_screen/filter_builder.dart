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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: filters.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: DriveFilterChip(
                        filter: filters.elementAt(index), onTap: onTap),
                  ))),
    );
  }
}
