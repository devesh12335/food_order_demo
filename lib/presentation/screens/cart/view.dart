import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return CartLoadedPage();
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
  const CartLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: Text('Cart',style: TextStyle(fontSize: 30),),),);
  }
}
