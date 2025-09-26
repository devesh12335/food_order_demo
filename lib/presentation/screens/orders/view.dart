import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/presentation/widgets/order_card.dart';
import 'package:intl/intl.dart';

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
      
        },
        builder: (context, state) {
          switch (state.status) {
            case OrdersStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case OrdersStatus.loaded:
              return OrdersLoadedPage(state: state,);
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
  final OrdersState state;
   const OrdersLoadedPage({super.key,required this.state});

 String _formatCurrency(int? amount) {
    if (amount == null) return '\u{20B9}0.00';
    return '\u{20B9}${(amount).toStringAsFixed(2)}';
  }

 
  String _formatTimestamp(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
     
      final dateTime = DateTime.parse(dateString);
      
      
      final formatter = DateFormat('MMM d, yyyy'); 
      return formatter.format(dateTime);
    } catch (e) {
      
      return dateString;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.amber.shade700;
      case 'cancelled':
        return Colors.red;
      case 'preparing':
        return Colors.blue.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = state.orders?.data ?? [];
       return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Orders'),
        
        elevation: 10,
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 10),
                  const Text(
                    'No recent orders found.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: orders[index], formatCurrency: _formatCurrency, getStatusColor: _getStatusColor, formatTimestamp: _formatTimestamp);
              },
            ),
    );
  }
}
