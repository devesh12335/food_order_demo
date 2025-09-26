import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/global_state/globalState.dart';
import 'package:food_orders/models/cart_model.dart';
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/presentation/resources/color_manager.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
   
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
 
  CartLoadedPage({super.key,required this.state});


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        
        elevation: 10,
      ),
      body: state.cartItems!.isEmpty
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
              itemCount: state.cartItems!.length,
              itemBuilder: (context, index) {
                return _buildCartItem(state.cartItems![index],context);
              },
            ),
      

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildCheckoutButton(context),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<CartBloc>().add(CheckoutEvent(context: context));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Checking out total: \u{20B9}${(state.totalPrice??0).toStringAsFixed(2)}'),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange, 
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), 
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
                '\u{20B9}${(state.totalPrice??0).toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  
  }

   Widget _buildCartItem(CartModel item,BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: item.item.image != null && item.item.image!.isNotEmpty
                      ? Image.network(
                          item.item.image!,
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
               
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.item.name ?? 'Unknown Item',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.item.category ?? 'N/A',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                
                Text(
                  '\u{20B9}${(item.item.price!).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),

            SizedBox(
              width: 100,height: 50,
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  IconButton(onPressed: ()=>context.read<CartBloc>().add(increaseQtyEvent(item: item)), icon: Icon(Icons.add,color: ColorManager.primary,)),
                  CircleAvatar(
                    
                    backgroundColor: ColorManager.primary.withAlpha(50),
                    child: Text("${item.Quntity}",style: TextStyle(color: Colors.black),),),
                   IconButton(onPressed: ()=>context.read<CartBloc>().add(decreaseQtyEvent(item: item)), icon: Icon(Icons.remove,color: ColorManager.primary,)),
                ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}
