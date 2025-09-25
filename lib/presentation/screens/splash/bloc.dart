import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<SplashInitEvent>(_onInit);
  }

  Future<void> _onInit(SplashInitEvent event, Emitter<SplashState> emit) async {
    try {
      emit(state.copyWith(status: SplashStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: SplashStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.error, error: e.toString()));
    }
  }
}
