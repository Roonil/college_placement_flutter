import 'package:flutter/material.dart';

import '../dummy_data/filter_actions.dart';
import '../models/filter.dart';

class DriveFilterChip extends StatefulWidget {
  const DriveFilterChip({super.key, required this.filter, required this.onTap});
  final Filter filter;
  final Function(FilterType) onTap;

  @override
  State<DriveFilterChip> createState() => _DriveFilterChipState();
}

class _DriveFilterChipState extends State<DriveFilterChip> {
  int? selectedEntry;
  final MenuController menuController = MenuController();
  @override
  Widget build(BuildContext context) {
    final List<MenuItemButton> menuChildren = [];

    for (int i = 0; i < widget.filter.filterItems.length; i++) {
      menuChildren.add(MenuItemButton(
        child: FilterChip.elevated(
          elevation: 5,
          label: Text(widget.filter.filterItems.entries.elementAt(i).value),
          labelStyle: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          backgroundColor: Theme.of(context).colorScheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          onSelected: (value) => setState(() => {
                menuController.isOpen
                    ? menuController.close()
                    : menuController.open(),
                selectedEntry = i,
                //      widget.filter.isSelected = !(widget.filter.isSelected),
                widget.onTap(widget.filter.filterItems.keys.elementAt(i)),
              }),
        ),
      ));
    }
    // return FilterChip.elevated(
    //   label: Text(widget.filter.name),
    //   labelStyle: Theme.of(context).textTheme.labelMedium,
    //   selected: widget.filter.isSelected,
    //   elevation: 5,
    //   pressElevation: 7,
    //   onSelected: (value) => {
    //     setState(() => {
    //           widget.filter.isSelected = !(widget.filter.isSelected),
    //           widget.onTap(value ? 1 : -1),
    //         }),
    //   },
    //   backgroundColor: Theme.of(context).colorScheme.tertiary,
    //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //   visualDensity: VisualDensity.compact,
    // );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuAnchor(
            controller: menuController,
            style: const MenuStyle(
              alignment: FractionalOffset(-.05, -10),
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
              surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
              shadowColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            menuChildren: menuChildren,
            builder: (context, controller, child) => FilterChip.elevated(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(selectedEntry != null
                          ? widget.filter.filterItems.entries
                              .elementAt(selectedEntry ?? 0)
                              .value
                          : widget.filter.name),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 17,
                      )
                    ],
                  ),
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  labelPadding: const EdgeInsets.only(left: 8),
                  selectedColor: selectedEntry == null
                      ? null
                      : Theme.of(context).colorScheme.tertiary,
                  selected: true,
                  showCheckmark: selectedEntry != null,
                  elevation: 5,
                  pressElevation: 7,
                  onSelected: (value) => {
                    controller.isOpen ? controller.close() : controller.open(),
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                )),
        selectedEntry == null
            ? const SizedBox()
            : IconButton(
                onPressed: () => {
                  selectedEntry = null,
                  widget.onTap(widget.filter.clearType)
                },
                icon: const Icon(Icons.cancel_rounded),
                iconSize: 20,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
      ],
    );
  }
}
