import 'package:flutter/foundation.dart' show immutable;

import '../dummy_data/filter_actions.dart';

@immutable
abstract class FilterEvent {
  const FilterEvent();
}

@immutable
class ApplyFilterEvent implements FilterEvent {
  final FilterType filterType;

  const ApplyFilterEvent({required this.filterType});
}

@immutable
class RemoveFilterEvent implements FilterEvent {
  final FilterType filterType;

  const RemoveFilterEvent({required this.filterType});
}
