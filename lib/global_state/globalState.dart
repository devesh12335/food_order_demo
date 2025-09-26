import 'package:food_orders/models/food_list_model.dart';

class GlobalState {
  final Map<dynamic, dynamic> _data = <dynamic, dynamic>{};

  static GlobalState instance = GlobalState._();

  GlobalState._();

  set(dynamic key, dynamic value) => _data[key] = value;

  get(dynamic key) => _data[key];

  List<FoodItem> CartItemList = [];
}
