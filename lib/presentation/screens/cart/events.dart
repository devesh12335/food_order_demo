import 'package:flutter/material.dart';
import 'package:food_orders/models/cart_model.dart';

abstract class CartEvent {}

class CheckoutEvent extends CartEvent {
  BuildContext context;
 
  CheckoutEvent({required this.context});
}


class decreaseQtyEvent extends CartEvent {
    CartModel item;
  decreaseQtyEvent({required this.item});
}


class increaseQtyEvent extends CartEvent {
  CartModel item;
  increaseQtyEvent({required this.item});
}


class updateTotalPriceEvent extends CartEvent {}


class CartInitEvent extends CartEvent {}
