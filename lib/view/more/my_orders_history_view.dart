import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_order_view.dart';
import 'order_details_view.dart';


class MyOrdersHistoryView extends StatefulWidget {
  const MyOrdersHistoryView({super.key});

  @override
  State<MyOrdersHistoryView> createState() =>
      _MyOrdersHistoryViewState();
}

class _MyOrdersHistoryViewState
    extends State<MyOrdersHistoryView> {

  String selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Order History "),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(
              child: Text("No Orders Found"),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              final order =
                  orders[index].data()
                      as Map<String, dynamic>;

              final items = List<dynamic>.from(order["items"] ?? []);
              final itemNames = items.map((item) => item["name"]) .join(", ");

return InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailsView(order: order),
      ),
    );
  },
  child: Card(
    margin: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // FOOD IMAGE
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child:Image.asset(
        items.isNotEmpty &&
          items[0]["image"] != null &&
          items[0]["image"].toString().isNotEmpty
          ? items[0]["image"]
                  : "assets/img/menu_1.png",
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
             )
               ),

      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            // RESTAURANT NAME
            const Text(
              "Krushlila Pure Veg",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // DATE
            Text(
              order["createdAt"] != null
                  ? order["createdAt"]
                      .toDate()
                      .toString()
                      .substring(0, 16)
                  : "",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),


            //Item Names
          //   const SizedBox(height: 8),

          //    Text(
          //     itemNames,
          //  maxLines: 2,
          //        overflow: TextOverflow.ellipsis,
          //    style: const TextStyle(
          //        fontSize: 14,
          //      color: Colors.black54,
          //     ),
          //    ),  

          const SizedBox(height: 8),

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: items.map<Widget>((item) {
    return Text(
      "${item["name"]} x${item["qty"]}",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    );
  }).toList(),
),

const SizedBox(height: 10),

            // PRICE
            Text(
              "₹${order["total"]}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 5),

            // STATUS
            Text(
              "Status: ${order["status"]}",
              style: TextStyle(
                color: order["status"] ==
                        "Delivered"
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                // Expanded(
                //   child: OutlinedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => OrderDetailsView(order: order),
                //         ),
                //       );
                //     },
                //     child: const Text(
                //       "Details",
                //     ),
                //   ),
                // ),

                // const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Reorder",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
),
);
   













//               return Card(
//   margin: const EdgeInsets.all(10),
//   child: Padding(
//     padding: const EdgeInsets.all(16),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [

//         Text(
//           "Order Total: ₹${order["total"]}",
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         const SizedBox(height: 10),

//         const Text(
//           "Items",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         ...items.map(
//           (item) => Text(
//             "${item["name"]} x ${item["qty"]}",
//           ),
//         ),

//         const Divider(),

//         Text(
//           "Status: ${order["status"]}",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: order["status"] == "Delivered"
//                 ? Colors.green
//                 : Colors.orange,
//           ),
//         ),
//       ],
//     ),
//   ),
// );

              // return Card(
              //   margin: const EdgeInsets.all(10),
              //   child: ListTile(
              //     title: Text(
              //       "₹${order["total"]}",
              //     ),

              //     subtitle: Text(
              //       order["status"] ?? "Pending",
              //     ),

              //     trailing: const Icon(
              //       Icons.arrow_forward_ios,
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}