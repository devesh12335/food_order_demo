import 'package:equatable/equatable.dart';
import 'package:food_orders/models/food_list_model.dart';

class  CartModel extends Equatable{
  int Quntity = 0;
  FoodItem item;
  CartModel({required this.Quntity,required this.item});
  
  @override
  // TODO: implement props
  List<Object?> get props => [Quntity,item];
}