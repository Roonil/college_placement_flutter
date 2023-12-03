import '../dummy_data/filter_actions.dart';

class Filter {
  final String name;
  final String? selectedValue;
  final Map<FilterType, String> filterItems;
  final FilterType clearType;
  Filter(
      {required this.name,
      required this.selectedValue,
      required this.filterItems,
      required this.clearType});
}
