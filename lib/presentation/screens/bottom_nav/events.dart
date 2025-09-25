abstract class BottomNavEvent {}

class onItemTappedEvent extends BottomNavEvent {
  int selectedIndex;
  onItemTappedEvent({required this.selectedIndex});
}


class BottomNavInitEvent extends BottomNavEvent {}
