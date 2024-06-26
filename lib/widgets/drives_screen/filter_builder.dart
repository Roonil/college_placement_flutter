import 'package:flutter/material.dart';

import '../../dummy_data/filter_actions.dart';
import '../../models/filter.dart';
import './drive_filter_chip.dart';

class FilterBuilder extends StatelessWidget {
  const FilterBuilder({
    super.key,
    required this.filters,
    required this.applyFilterCallBack,
  });

  final Set<Filter> filters;
  final Function(FilterType) applyFilterCallBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: filters.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: DriveFilterChip(
                      filter: filters.elementAt(index),
                      applyFilterCallBack: applyFilterCallBack),
                )));
  }
}
