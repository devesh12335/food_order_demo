import 'package:equatable/equatable.dart';
import 'package:food_orders/models/order_list_model.dart';

enum OrdersStatus { initial, loading, loaded, error }

class OrdersState extends Equatable {
  final OrdersStatus status;
  final String? error;
  final OrderListModel? orders;

  const OrdersState({
    required this.status,
    this.error,
    this.orders,
  });

  factory OrdersState.initial() => const OrdersState(
    status: OrdersStatus.initial,
  );

  OrdersState copyWith({
    OrdersStatus? status,
    String? error,
    OrderListModel? orders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      error: error ?? this.error,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [status, error, orders];
}
