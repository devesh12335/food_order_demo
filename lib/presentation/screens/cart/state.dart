import 'package:equatable/equatable.dart';
import 'package:food_orders/models/cart_model.dart';

enum CartStatus { initial, loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final String? error;
 
  final double? totalPrice;
   List<CartModel>? cartItems;

   CartState({
    required this.status,
    this.error,
    
    this.totalPrice,
    this.cartItems,
  });

  factory CartState.initial() =>  CartState(
    status: CartStatus.initial,
   
  );

  CartState copyWith({
    CartStatus? status,
    String? error,
    
    double? totalPrice,
    List<CartModel>? cartItems,
  }) {
    return CartState(
      status: status ?? this.status,
      error: error ?? this.error,
     
      totalPrice: totalPrice ?? this.totalPrice,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [status, error, cartItems, totalPrice, ];
}
