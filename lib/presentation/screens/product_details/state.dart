import 'package:equatable/equatable.dart';

enum ProductDetailsStatus { initial, loading, loaded, error }

class ProductDetailsState extends Equatable {
  final ProductDetailsStatus status;
  final String? error;

  const ProductDetailsState({
    required this.status,
    this.error,
  });

  factory ProductDetailsState.initial() => const ProductDetailsState(
    status: ProductDetailsStatus.initial,
  );

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    String? error,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
