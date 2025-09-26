import 'package:flutter/widgets.dart';

abstract class BottomNavEvent {}

class GoToCartEvent extends BottomNavEvent {

BuildContext context;
GoToCartEvent({required this.context});
}


class onItemTappedEvent extends BottomNavEvent {
  int selectedIndex;
  onItemTappedEvent({required this.selectedIndex});
}


class BottomNavInitEvent extends BottomNavEvent {}
