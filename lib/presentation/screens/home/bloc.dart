import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitEvent>(_onInit);
    on<onSearchEvent>(_ononSearch);
}

  Future<void> _ononSearch(onSearchEvent event, Emitter<HomeState> emit) async {
    try {
   
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }




  Future<void> _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: HomeStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}
