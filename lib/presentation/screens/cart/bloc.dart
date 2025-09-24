import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<CartInitEvent>(_onInit);
  }

  Future<void> _onInit(CartInitEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: CartStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }
}
