import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class SearchProdutsBloc extends Bloc<SearchProdutsEvent, SearchProdutsState> {
  SearchProdutsBloc() : super(SearchProdutsState.initial()) {
    on<SearchProdutsInitEvent>(_onInit);
  }

  Future<void> _onInit(SearchProdutsInitEvent event, Emitter<SearchProdutsState> emit) async {
    try {
      emit(state.copyWith(status: SearchProdutsStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: SearchProdutsStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: SearchProdutsStatus.error, error: e.toString()));
    }
  }
}
