import 'package:flutter/material.dart';
import 'package:food_orders/models/store_list_model.dart';

abstract class HomeEvent {}

class onStoreTapEvent extends HomeEvent {
  BuildContext context;
  Store store;
  onStoreTapEvent({required this.context,required this.store});
}


class onSearchEvent extends HomeEvent {
  String query;
  onSearchEvent({required this.query});
}


class HomeInitEvent extends HomeEvent {}
