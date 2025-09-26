import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/global_state/globalState.dart';
import 'package:food_orders/models/food_list_model.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final cartItemList = (ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>);
    //  final cartItems = (cartItemList['list'] as List<Map<String,dynamic>>).map((obj)=>FoodItem.fromJson(obj)).toList();
    return BlocProvider(
      create: (_) => CartBloc()..add(CartInitEvent()),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case CartStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case CartStatus.loaded:
              return CartLoadedPage(state: state,);
            case CartStatus.error:
              return Scaffold(
                body: Center(
                  child: Text(state.error ?? "An error occurred"),
                ),
              );
            default:
              return const Scaffold(
                body: Center(child: Text("Unknown state")),
              );
          }
        },
      ),
    );
  }
}

class CartLoadedPage extends StatelessWidget {
  CartState state;
  // List<FoodItem> cartItems;
  CartLoadedPage({super.key,required this.state});

  double get _totalPrice {
    // Sums up all the prices (assuming price is in cents and converting to dollars)
    final totalCents = GlobalState.instance.CartItemList.fold(0, (sum, item) => sum + (item.price ?? 0));
    return double.parse("$totalCents") ;
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        
        elevation: 10,
      ),
      body: GlobalState.instance.CartItemList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 10),
                  const Text('Your cart is empty!',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 16.0, right: 16.0, bottom: 100.0),
              itemCount: GlobalState.instance.CartItemList.length,
              itemBuilder: (context, index) {
                return _buildCartItem(GlobalState.instance.CartItemList[index]);
              },
            ),
      
      // Checkout/Total Button at the bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildCheckoutButton(context),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: () {
          // Placeholder for checkout logic
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Checking out total: \u{20B9}${_totalPrice.toStringAsFixed(2)}'),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange, // Checkout action color
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Curved corners for button
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Proceed to Checkout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                '\u{20B9}${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  
  }

   Widget _buildCartItem(FoodItem item) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Curved corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image (Placeholder or URL)
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: item.image != null && item.image!.isNotEmpty
                  ? Image.network(
                      item.image!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(Icons.fastfood, color: Colors.grey),
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300],
                      child: const Icon(Icons.fastfood, color: Colors.grey),
                    ),
            ),
            const SizedBox(width: 15),
            
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? 'Unknown Item',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Price
            Text(
              '\u{20B9}${(item.price!).toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
