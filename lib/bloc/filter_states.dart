import 'package:flutter/foundation.dart' show immutable;

import '../dummy_data/filter_actions.dart';

@immutable
abstract class FilterState {
  const FilterState();
}

@immutable
class InitialState extends FilterState {
  const InitialState();
}

@immutable
class AppliedFilterState extends FilterState {
  final FilterType filterType;
  const AppliedFilterState({required this.filterType});
}

@immutable
class RemovedFilterState extends FilterState {
  final FilterType filterType;

  const RemovedFilterState({required this.filterType});
}
