import '../../dummy_data/filter_actions.dart';

import 'package:flutter/material.dart';

import '../../dummy_data/filters.dart';
import 'filter_builder.dart';
import 'filter_functions.dart';
import 'search_criteria_builder.dart';
import 'sort_criteria_builder.dart';

class SortAndFilter extends StatefulWidget {
  const SortAndFilter(
      {super.key,
      required this.applyFilterCallBack,
      required this.criterias,
      required this.onChanged});
  final Function(FilterType) applyFilterCallBack;
  final Map<String, Function(bool)> criterias;
  final Function(bool) onChanged;
  @override
  State<SortAndFilter> createState() => _SortAndFilterState();
}

class _SortAndFilterState extends State<SortAndFilter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FilterBuilder(
                  filters: filters,
                  applyFilterCallBack: widget.applyFilterCallBack),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              const SearchCriteriaBuilder(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              SortCriteriaBuilder(criterias: widget.criterias),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Show Expired Drives"),
                    Switch(
                        value: FilterFunctions.showExpired,
                        onChanged: (value) => setState(() {
                              widget.onChanged(value);
                            })),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
