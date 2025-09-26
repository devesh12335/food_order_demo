import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/global_state/globalState.dart';

import 'events.dart';
import 'state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsState.initial()) {
    on<ProductDetailsInitEvent>(_onInit);
    on<GoToCartEvent>(_onGoToCart);
}

  Future<void> _onGoToCart(GoToCartEvent event, Emitter<ProductDetailsState> emit) async {
    try {
        GlobalState.instance.CartItemList.add(event.item);
    } catch (e) {
      emit(state.copyWith(status: ProductDetailsStatus.error, error: e.toString()));
    }
  }




  Future<void> _onInit(ProductDetailsInitEvent event, Emitter<ProductDetailsState> emit) async {
    try {
      emit(state.copyWith(status: ProductDetailsStatus.loading));
      // Iniatial task here
      emit(state.copyWith(
        status: ProductDetailsStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(status: ProductDetailsStatus.error, error: e.toString()));
    }
  }
}
