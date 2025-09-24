import 'package:equatable/equatable.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final String? error;

  const CartState({
    required this.status,
    this.error,
  });

  factory CartState.initial() => const CartState(
    status: CartStatus.initial,
  );

  CartState copyWith({
    CartStatus? status,
    String? error,
  }) {
    return CartState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
