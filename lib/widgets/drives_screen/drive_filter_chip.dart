import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/filter_bloc.dart';
import '../../bloc/filter_events.dart';
import '../../dummy_data/filter_actions.dart';
import '../../models/filter.dart';

class DriveFilterChip extends StatefulWidget {
  const DriveFilterChip({super.key, required this.filter, required this.onTap});
  final Filter filter;
  final Function(FilterType) onTap;

  @override
  State<DriveFilterChip> createState() => _DriveFilterChipState();
}

class _DriveFilterChipState extends State<DriveFilterChip> {
  FilterType? selectedEntry;
  final MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: Text(widget.filter.name)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Flexible(
                child: Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    children: widget.filter.filterItems.entries
                        .map((entry) => FilterChip(
                              selected: selectedEntry == entry.key,
                              padding: const EdgeInsets.all(6),
                              side: BorderSide(
                                  width: 0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withAlpha(120)),
                              label: Text(entry.value),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              onSelected: (value) {
                                setState(() {
                                  selectedEntry == entry.key
                                      ? {
                                          selectedEntry = null,
                                          widget.onTap(widget.filter.clearType),
                                          BlocProvider.of<FilterBloc>(context)
                                              .add(RemoveFilterEvent(
                                                  filterType: entry.key)),
                                        }
                                      : {
                                          selectedEntry != null
                                              ? BlocProvider.of<FilterBloc>(
                                                      context)
                                                  .add(RemoveFilterEvent(
                                                      filterType:
                                                          selectedEntry!))
                                              : null,
                                          selectedEntry = entry.key,
                                          widget.onTap(entry.key),
                                          BlocProvider.of<FilterBloc>(context)
                                              .add(ApplyFilterEvent(
                                                  filterType: entry.key))
                                        };
                                });
                              },
                            ))
                        .toList()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
