import 'package:flutter/material.dart';
import 'search_criteria_chip.dart';

class SearchCriteriaBuilder extends StatelessWidget {
  const SearchCriteriaBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text("Search in:")),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 12,
              alignment: WrapAlignment.start,
              children: [
                SearchCriteriaChip(
                  criteria: "Name",
                ),
                SearchCriteriaChip(
                  criteria: "Description",
                ),
                SearchCriteriaChip(
                  criteria: "Roles",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
