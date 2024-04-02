import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../dummy_data/filter_actions.dart';
import 'filter_events.dart';
import 'filter_states.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final Set<FilterType> filterTypes = {};

  FilterBloc() : super(const InitialState()) {
    on<ApplyFilterEvent>(_applyFilterEvent);
    on<RemoveFilterEvent>(_removeFilterEvent);
  }

  FutureOr<void> _applyFilterEvent(
      ApplyFilterEvent event, Emitter<FilterState> emit) {
    filterTypes.add(event.filterType);
    emit(AppliedFilterState(filterType: event.filterType));
  }

  FutureOr<void> _removeFilterEvent(
      RemoveFilterEvent event, Emitter<FilterState> emit) {
    filterTypes.remove(event.filterType);
    emit(RemovedFilterState(filterType: event.filterType));
  }
}
