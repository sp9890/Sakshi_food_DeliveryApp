import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_button.dart';

import 'change_address_view.dart';
import 'checkout_message_view.dart';
import '../../services/order_service.dart';

//import '../../common/cart_service.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';


import 'package:cloud_firestore/cloud_firestore.dart';



class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});



  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List paymentArr = [
    {"name":"Cash on delivery (Pay at Doorstep)","icon":"assets/img/rupee.png",
    // {"name": "**** **** **** 2187", "icon": "assets/img/visa_icon.png"},
    // {"name": "test@gmail.com", "icon": "assets/img/paypal.png"},

      "name": "Cash on delivery (Pay at Doorstep)",
      "icon": "assets/img/rupee.png",

      },
     
  ];

 

  int selectMethod = 0;

  String customerName = "";
  String customerPhone = "";
  String customerAddress = "";


double subtotal = 0;
double deliveryFee = 40;
double total = 0;

 

//   Future<void> loadProfile() async {
//   final doc = await FirebaseFirestore.instance
//       .collection("users")
//       .doc("customer_profile")
//       .get();

//   if (doc.exists) {
//     setState(() {
//       customerName = doc["name"] ?? "";
//       customerPhone = doc["phone"] ?? "";
//       customerAddress = doc["address"] ?? "";
//     });
//   }
// }

@override
void initState() {
  super.initState();
  loadProfile();
 // calculateTotals();

}
Future<void> loadProfile() async {
  final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc("customer_profile")
      .get();

  if (doc.exists) {
    setState(() {
      customerName = doc["name"] ?? "";
      customerPhone = doc["phone"] ?? "";
      customerAddress = doc["address"] ?? "";
    });
  }
}





  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: TColor.white,
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
                    Expanded(
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Address",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: TColor.secondaryText, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: Text(
                        //     "653 Nostrand Ave.\nBrooklyn, NY 11216",
                        //     style: TextStyle(
                        //         color: TColor.primaryText,
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w700),
                        //   ),
                        // ),
                         


                         Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        customerName,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        customerPhone,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 13,
        ),
      ),

      const SizedBox(height: 4),

      Text(
        customerAddress,
        style: TextStyle(
          color: TColor.primaryText,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),



                        const SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeAddressView()),
                            );
                          },
                          child: Text(
                            "Change",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: TColor.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: TColor.textfield),
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment method",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: TColor.primary),
                          label: Text(
                            "Add Card",
                            style: TextStyle(
                                color: TColor.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: paymentArr.length,
                        itemBuilder: (context, index) {
                          var pObj = paymentArr[index] as Map? ?? {};
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                color: TColor.textfield,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        TColor.secondaryText.withValues(alpha: 0.2))),
                            child: Row(
                              children: [
                                Image.asset(pObj["icon"].toString(),
                                    width: 50, height: 20, fit: BoxFit.contain),
                                // const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    pObj["name"],
                                    style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectMethod = index;
                                    });
                                  },
                                  child: Icon(
                                    selectMethod == index
                                        ? Icons.radio_button_on
                                        : Icons.radio_button_off,
                                    color: TColor.primary,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: TColor.textfield),
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹${cart.subTotal.toStringAsFixed(0)}",

                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Cost",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹${deliveryFee.toStringAsFixed(0)}",

                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Discount",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: TColor.primaryText,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //     Text(
                    //       "₹${total.toStringAsFixed(0)}",

                    //       style: TextStyle(
                    //           color: TColor.primaryText,
                    //           fontSize: 13,
                    //           fontWeight: FontWeight.w700),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Divider(
                      color: TColor.secondaryText.withValues(alpha: 0.5),
                      height: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                           //"₹${total.toStringAsFixed(0)}",
                           "₹${(cart.subTotal + deliveryFee).toStringAsFixed(0)}",

                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: TColor.textfield),
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: RoundButton(
                    title: "Send Order",
                    onPressed: () async {
                      
  List<Map<String, dynamic>> orderItems = [];
  double subtotal = 0;
 
   for (var item in cart.cartItems){
    orderItems.add({
      "name": item.name,
      "price": item.price,
      "qty": item.qty,
      "image": item.image,
    });

    subtotal += item.price * item.qty; }
  double deliveryFee = 40;
  double total = subtotal + deliveryFee;
  // await OrderService.saveOrder(
  //   items: orderItems,
  //   subtotal: subtotal,
  //   deliveryFee: deliveryFee,
  //   total: total,
  // );
 
  print("Cart Items Count: ${cart.cartItems.length}");
  print(cart.cartItems);
  print("ORDER ITEMS BEFORE SAVE = $orderItems");

  
  print("ORDER ITEMS = $orderItems");
  print("SUBTOTAL = $subtotal");

  await OrderService.saveOrder(
  items: orderItems,
  subtotal: subtotal,
  deliveryFee: deliveryFee,
  total: total,
  customerName: customerName,
  phone: customerPhone,
  address: customerAddress,
);


cart.clearCart();

// calculateTotals();

setState(() {});
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) {
                            return const CheckoutMessageView();
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
