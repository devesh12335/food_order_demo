
import 'package:flutter/material.dart';
import 'package:food_orders/models/order_list_model.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final String Function(int?) formatCurrency;
  final Color Function(String?) getStatusColor;
  final String Function(String?) formatTimestamp; 

  const OrderCard({
    required this.order,
    required this.formatCurrency,
    required this.getStatusColor,
    required this.formatTimestamp, 
  });

String formatDeliveryTime(String? deliveryTimeString) {
  if (deliveryTimeString == null || deliveryTimeString.isEmpty) {
    return 'Not Specified';
  }
 
  if (deliveryTimeString.length > 1) {
    return deliveryTimeString[0].toUpperCase() + deliveryTimeString.substring(1);
  }
  return deliveryTimeString;
}

  @override
  Widget build(BuildContext context) {
  
    IconData deliveryIcon;
    switch (order.status?.toLowerCase()) {
      case 'delivered':
        deliveryIcon = Icons.check_circle;
        break;
      case 'pending':
        deliveryIcon = Icons.access_time;
        break;
      case 'cancelled':
        deliveryIcon = Icons.cancel;
        break;
      default:
        deliveryIcon = Icons.local_shipping;
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderId ?? 'N/A'}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                 
                  formatTimestamp(order.orderDate),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const Divider(height: 16, thickness: 1),

          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status:',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Row(
                      children: [
                        Icon(deliveryIcon, size: 16, color: getStatusColor(order.status)),
                        const SizedBox(width: 4),
                        Text(
                          order.status ?? 'N/A',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(order.status),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    Text(
                      formatCurrency(order.totalAmount),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            
           
            if (order.status?.toLowerCase() == 'preparing' || order.status?.toLowerCase() == 'pending')
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      'Estimated Delivery: ${formatDeliveryTime(order.deliveryTime) ?? '30-45 mins'}',
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              
           
            Text(
              'Items (${order.products?.length ?? 0}):',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            ...order.products!.take(2).map((p) => Text(
                  '  - ${p.quantity}x ${p.name}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                )).toList(),
            if (order.products!.length > 2)
              Text(
                '  ...and ${order.products!.length - 2} more',
                style: TextStyle(fontSize: 14, color: Colors.grey[500], fontStyle: FontStyle.italic),
              ),

            const SizedBox(height: 12),
          
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reordering #${order.orderId}')),
                  );
                },
                icon: const Icon(Icons.refresh, size: 18, color: Colors.deepOrange),
                label: const Text('Re-Order', style: TextStyle(color: Colors.deepOrange)),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(color: Colors.deepOrange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}