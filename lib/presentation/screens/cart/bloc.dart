import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/global_state/globalState.dart';
import 'package:food_orders/models/cart_model.dart';
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/presentation/screens/checkout/view.dart';

import 'events.dart';
import 'state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<CartInitEvent>(_onInit);
    on<updateTotalPriceEvent>(_onupdateTotalPrice);
    on<increaseQtyEvent>(_onincreaseQty);
    on<decreaseQtyEvent>(_ondecreaseQty);
    on<CheckoutEvent>(_onCheckout);
}

  Future<void> _onCheckout(CheckoutEvent event, Emitter<CartState> emit) async {
    try {
        Navigator.of(event.context).push(MaterialPageRoute(builder: (context)=>CheckoutScreen(subtotalPrice: state.totalPrice??0)));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }




  _ondecreaseQty(
    decreaseQtyEvent event,
    Emitter<CartState> emit,
  )  {
    try {
      List<CartModel> products =List.from(state.cartItems ?? []); 
      int index = products.indexWhere((ele) => ele.item == event.item.item);
      if (index != -1) {
        if (event.item.Quntity > 0) {
          final updatedItem = CartModel(
            Quntity: products[index].Quntity - 1,
            item: event.item.item,
          );
          products[index] = updatedItem;
        }
        
      }
add(updateTotalPriceEvent());
      emit(state.copyWith(cartItems: products));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  _onincreaseQty(
    increaseQtyEvent event,
    Emitter<CartState> emit,
  )  {
    try {
      List<CartModel> products =List.from(state.cartItems ?? []); 
      int index = products.indexWhere((ele) => ele.item == event.item.item);
      if (index != -1) {
        final updatedItem = CartModel(
          Quntity: products[index].Quntity + 1,
          item: event.item.item,
        );
        products[index] = updatedItem;
      }
add(updateTotalPriceEvent());
      emit(state.copyWith(cartItems: products));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _onupdateTotalPrice(
    updateTotalPriceEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      double total = state.cartItems!.fold(0, (accumulator, cartItem) {
   
    final price = cartItem.item.price ?? 0;
    final quantity = cartItem.Quntity;

    return accumulator + (price * quantity);
  });
  emit(state.copyWith(totalPrice: double.parse("$total")));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }

  Future<void> _onInit(CartInitEvent event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      List<FoodItem> products = GlobalState.instance.CartItemList;
      List<CartModel> cartList = products
          .map((e) => CartModel(Quntity: 1, item: e))
          .toList();
          add(updateTotalPriceEvent());
      emit(state.copyWith(status: CartStatus.loaded, cartItems: cartList));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error, error: e.toString()));
    }
  }
}
