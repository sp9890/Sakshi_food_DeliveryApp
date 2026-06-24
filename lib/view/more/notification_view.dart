import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';

import 'my_order_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  String customerPhone = "";

 Future<void> loadCustomerPhone() async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc('customer_profile')
      .get();

  if (doc.exists) {
    setState(() {
      customerPhone = doc['phone'] ?? '';
    });
    print("Customer Phone = $customerPhone");
  }
}

@override
  void initState() {
    super.initState();
    loadCustomerPhone();
  }



  List notificationArr = [
    {
      "title": "Your orders has been picked up",
      "time": "Now",
    },
    {
      "title": "Your order has been delivered",
      "time": "1 h ago",
    },
    {
      "title": "Your orders has been picked up",
      "time": "3 h ago",
    },
    {
      "title": "Your order has been delivered",
      "time": "5 h ago",
    },
    {
      "title": "Your orders has been picked up",
      "time": "05 Jun 2023",
    },
    {
      "title": "Your order has been delivered",
      "time": "05 Jun 2023",
    },
    {
      "title": "Your orders has been picked up",
      "time": "06 Jun 2023",
    },
    {
      "title": "Your order has been delivered",
      "time": "06 Jun 2023",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset("assets/img/btn_back.png",
                          width: 20, height: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // Expanded(
                      StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('notifications')
      //.where('phone', isEqualTo: customerPhone)
      .orderBy('createdAt', descending: true)
      .snapshots(),
  builder: (context, snapshot) {

    int count = snapshot.data?.docs.length ?? 0;

    return Text(
      "Notifications ($count)",
      style: TextStyle(
        color: TColor.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  },
),
                    //   child: Text(
                    //     "Notifications",
                    //     style: TextStyle(
                    //         color: TColor.primaryText,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.w800),
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyOrderView()));
                      },
                      icon: Image.asset(
                        "assets/img/shopping_cart.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),

StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('notifications')
      //.where('phone', isEqualTo: customerPhone)
      .orderBy('createdAt', descending: true)
      .snapshots(),
  builder: (context, snapshot) {

    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final notifications = snapshot.data!.docs;

    if (notifications.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text("No Notifications"),
      );
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: notifications.length,

      separatorBuilder: (context, index) => Divider(
        indent: 25,
        endIndent: 25,
        color: TColor.secondaryText.withValues(alpha: 0.4),
        height: 1,
      ),

      itemBuilder: (context, index) {

        final data =
            notifications[index].data()
                as Map<String, dynamic>;

        return Container(
          decoration: BoxDecoration(
            color: index % 2 == 0
                ? TColor.white
                : TColor.textfield,
          ),

          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: TColor.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      data['title'] ?? '',
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      data['message'] ?? '',
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}



//               ListView.separated(
//                 physics: const NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 itemCount: notificationArr.length,
//                 separatorBuilder: ((context, index) => Divider(
//                   indent: 25,
//                   endIndent: 25,
//                       color: TColor.secondaryText.withValues(alpha: 0.4),
//                       height: 1,
//                     )),
//                 itemBuilder: ((context, index) {
//                   var cObj = notificationArr[index] as Map? ?? {};
//                   return Container(
//                     decoration: BoxDecoration(color: index % 2 == 0 ? TColor.white : TColor.textfield ),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 25),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 4),
//                           width: 8,
//                           height: 8,
//                           decoration: BoxDecoration(
//                               color: TColor.primary,
//                               borderRadius: BorderRadius.circular(4)),
//                         ),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 cObj["title"].toString(),
//                                 style: TextStyle(
//                                     color: TColor.primaryText,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               Text(
//                                 cObj["time"].toString(),
//                                 style: TextStyle(
//                                     color: TColor.secondaryText,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
