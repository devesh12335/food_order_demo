import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState.initial()) {
    on<BottomNavInitEvent>(_onInit);
    on<onItemTappedEvent>(_ononItemTapped);
}

  Future<void> _ononItemTapped(onItemTappedEvent event, Emitter<BottomNavState> emit) async {
    try {
   emit(state.copyWith( selectedIndex: event.selectedIndex));
    } catch (e) {
      emit(state.copyWith(status: BottomNavStatus.error, error: e.toString()));
    }
  }




  Future<void> _onInit(BottomNavInitEvent event, Emitter<BottomNavState> emit) async {
    try {
      emit(state.copyWith(status: BottomNavStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: BottomNavStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: BottomNavStatus.error, error: e.toString()));
    }
  }
}
