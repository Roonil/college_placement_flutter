import 'package:flutter/material.dart';
import 'sort_criteria_chip.dart';

class SortCriteriaBuilder extends StatefulWidget {
  final Map<String, Function(bool)> criterias;

  const SortCriteriaBuilder({super.key, required this.criterias});

  @override
  State<SortCriteriaBuilder> createState() => _SortCriteriaBuilderState();
}

class _SortCriteriaBuilderState extends State<SortCriteriaBuilder> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> columnChildren = [];
    widget.criterias.forEach(
      (criteriaName, criteriaCallBack) => columnChildren.add(SortCriteriaChip(
        criteria: criteriaName,
        onSelected: (value) => setState(() {
          criteriaCallBack(value);
        }),
      )),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sort By:"),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 12,
                alignment: WrapAlignment.start,
                children: columnChildren,
              ),
            )
          ]),
    );
  }
}
