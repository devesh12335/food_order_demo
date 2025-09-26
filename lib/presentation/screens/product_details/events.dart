import 'package:food_orders/models/food_list_model.dart';

abstract class ProductDetailsEvent {}

class GoToCartEvent extends ProductDetailsEvent {
  FoodItem item;
  GoToCartEvent({required this.item});
}


class ProductDetailsInitEvent extends ProductDetailsEvent {}
