import 'package:equatable/equatable.dart';
import 'package:food_orders/models/food_list_model.dart';

enum ProductsDisplayStatus { initial, loading, loaded, error }

class ProductsDisplayState extends Equatable {
  final ProductsDisplayStatus status;
  final String? error;
  final FoodListModel? allFoodList;

  const ProductsDisplayState({
    required this.status,
    this.error,
    this.allFoodList,
  });

  factory ProductsDisplayState.initial() => const ProductsDisplayState(
    status: ProductsDisplayStatus.initial,
  );

  ProductsDisplayState copyWith({
    ProductsDisplayStatus? status,
    String? error,
    FoodListModel? allFoodList,
  }) {
    return ProductsDisplayState(
      status: status ?? this.status,
      error: error ?? this.error,
      allFoodList: allFoodList ?? this.allFoodList,
    );
  }

  @override
  List<Object?> get props => [status, error, allFoodList];
}
