import 'package:equatable/equatable.dart';

enum OrdersStatus { initial, loading, loaded, error }

class OrdersState extends Equatable {
  final OrdersStatus status;
  final String? error;

  const OrdersState({
    required this.status,
    this.error,
  });

  factory OrdersState.initial() => const OrdersState(
    status: OrdersStatus.initial,
  );

  OrdersState copyWith({
    OrdersStatus? status,
    String? error,
  }) {
    return OrdersState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
