import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  static Future<void> saveOrder({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double deliveryFee,
    required double total,
  }) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .add({
      "items": items,
      "subtotal": subtotal,
      "deliveryFee": deliveryFee,
      "total": total,
      "status": "Pending",
      "createdAt": Timestamp.now(),
    });
  }
}