import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class OrderService {
//   static Future<void> saveOrder({
//     required List<Map<String, dynamic>> items,
//     required double subtotal,
//     required double deliveryFee,
//     required double total,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("orders")
//         .add({
//       "items": items,
//       "subtotal": subtotal,
//       "deliveryFee": deliveryFee,
//       "total": total,
//       "status": "Pending",
//       "createdAt": Timestamp.now(),
//     });
//   }
// }


static Future<void> saveOrder({
  required List<Map<String, dynamic>> items,
  required double subtotal,
  required double deliveryFee,
  required double total,
  required String customerName,
  required String phone,
  required String address,
}) async {

  print("SAVE ORDER STARTED");
  print("ORDER ITEMS = $items");
  print("SUBTOTAL = $subtotal");

  String? token =
    await FirebaseMessaging.instance.getToken();

     print("ORDER TOKEN = $token");

  await FirebaseFirestore.instance
      .collection("orders")
      .add({
    // "customerName": customerName,
    // "phone": phone,
    // "address": address,
    // "items": items,
    // "subtotal": subtotal,
    // "deliveryFee": deliveryFee,
    // "total": total,
    // "status": "Pending",
    // "createdAt": Timestamp.now(),
     // "userId": FirebaseAuth.instance.currentUser!.uid,

      "customerName": customerName,
      "phone": phone,
      "address": address,

       "items": items,
       "subtotal": subtotal,
       "deliveryFee": deliveryFee,
       "total": total,

        "fcmToken": token,   

       "status": "Pending",
       "createdAt": Timestamp.now(),
 
 
 
  });
}
}