import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState.initial()) {
    on<OrdersInitEvent>(_onInit);
  }

  Future<void> _onInit(OrdersInitEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(state.copyWith(status: OrdersStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: OrdersStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: OrdersStatus.error, error: e.toString()));
    }
  }
}
