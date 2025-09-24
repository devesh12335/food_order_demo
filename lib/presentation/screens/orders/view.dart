import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersBloc()..add(OrdersInitEvent()),
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case OrdersStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case OrdersStatus.loaded:
              return OrdersLoadedPage();
            case OrdersStatus.error:
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

class OrdersLoadedPage extends StatelessWidget {
  const OrdersLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: Text('Orders',style: TextStyle(fontSize: 30),),),);
  }
}
