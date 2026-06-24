import 'package:flutter/material.dart';

class OrderDetailsView extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsView({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Customer: ${order["customerName"] ?? ""}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Phone: ${order["phone"] ?? ""}",
            ),

            const SizedBox(height: 10),

            Text(
              "Address: ${order["address"] ?? ""}",
            ),

            const SizedBox(height: 20),

            Text(
              "Total: ₹${order["total"]}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Status: ${order["status"]}",
            ),
          ],
        ),
      ),
    );
  }
}