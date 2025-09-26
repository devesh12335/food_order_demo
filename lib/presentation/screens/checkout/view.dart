import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final double subtotalPrice;

  const CheckoutScreen({super.key, required this.subtotalPrice});

  static const double _deliveryFee = 5.00;
  static const double _taxRate = 0.08; // 8% tax

  static const String _userName = 'Alex Johnson';
  static const String _userAddress =
      '123 Main Street, Apt 4B, Anytown, CA 90210';
  static const String _userPaymentMethod = 'Visa ending in 4242';

  double get _taxAmount => subtotalPrice * _taxRate;
  double get _grandTotal => subtotalPrice + _deliveryFee + _taxAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), elevation: 10),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Delivery Information 🛵'),
            _buildInfoCard(
              children: [
                _buildInfoRow('Name', _userName),
                _buildInfoRow('Address', _userAddress, isMultiline: true),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('Payment Method 💳'),
            _buildInfoCard(
              children: [
                _buildInfoRow('Selected', _userPaymentMethod),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment Method Changed'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Change'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _buildSectionTitle('Order Summary 🧾'),
            _buildInfoCard(
              children: [
                _buildPriceRow('Subtotal', subtotalPrice, Colors.black),

                _buildPriceRow('Delivery Fee', _deliveryFee, Colors.orange),

                _buildPriceRow('Taxes ($_taxRate%)', _taxAmount, Colors.red),

                const Divider(height: 20, thickness: 1.5),

                _buildPriceRow(
                  'Grand Total',
                  _grandTotal,
                  Colors.teal,
                  isTotal: true,
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildPlaceOrderButton(context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            maxLines: isMultiline ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }


  Widget _buildPriceRow(
    String label,
    double amount,
    Color color, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? color : Colors.black87,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order Placed Successfully'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), 
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          'Place Order - \$${_grandTotal.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
