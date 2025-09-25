abstract class HomeEvent {}

class onSearchEvent extends HomeEvent {
  String query;
  onSearchEvent({required this.query});
}


class HomeInitEvent extends HomeEvent {}
