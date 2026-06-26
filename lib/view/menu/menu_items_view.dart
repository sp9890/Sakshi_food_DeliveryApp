import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_textfield.dart';

import '../../common_widget/menu_item_row.dart';
import '../more/my_order_view.dart';
import '../../common/cart_item.dart';
import '../../common/cart_service.dart';
import '../../services/menu_service.dart';
import 'item_details_view.dart';


class MenuItemsView extends StatefulWidget {
  final Map mObj;
  const MenuItemsView({super.key, required this.mObj});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  TextEditingController txtSearch = TextEditingController();

  List menuItemsArr = [];
    
    @override
void initState() {
  super.initState();
  loadMenu();
}
// Future<void> loadMenu() async {
//   final data = await MenuService.loadMenu();

//   setState(() {
//     menuItemsArr = data;
//   });
// }
Future<void> loadMenu() async {
  final data = await MenuService.loadMenu();

  final filteredItems = data.where((item) {
    return item["Category"] ==
        widget.mObj["name"];
  }).toList();

  setState(() {
    menuItemsArr = filteredItems;
  });
}

  //   {
  //     "image": "assets/img/dess_1.png",
  //     "name": "French Apple Pie",
  //     "price": 120.0,
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Minute by tuk tuk",
  //     "food_type": "Desserts"
      
  //   },
  //   {
  //     "image": "assets/img/dess_2.png",
  //     "name": "Dark Chocolate Cake",
  //      "price": 180.0,
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Cakes by Tella",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_3.png",
  //     "name": "Street Shake",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Café Racer",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_4.png",
  //     "name": "Fudgy Chewy Brownies",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Minute by tuk tuk",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_1.png",
  //     "name": "French Apple Pie",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Minute by tuk tuk",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_2.png",
  //     "name": "Dark Chocolate Cake",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Cakes by Tella",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_3.png",
  //     "name": "Street Shake",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Café Racer",
  //     "food_type": "Desserts"
  //   },
  //   {
  //     "image": "assets/img/dess_4.png",
  //     "name": "Fudgy Chewy Brownies",
  //     "rate": "4.9",
  //     "rating": "124",
  //     "type": "Minute by tuk tuk",
  //     "food_type": "Desserts"
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        widget.mObj["name"].toString(),
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDetailsView(mObj: widget.mObj)));
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  hintText: "Search Food",
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: menuItemsArr.length,
                // itemBuilder: ((context, index) {
                //   var mObj = menuItemsArr[index] as Map? ?? {};
                //   return MenuItemRow(
                //     mObj: mObj,


                  itemBuilder: ((context, index) {
                 var mObj = menuItemsArr[index] as Map? ?? {};

  List demoImages = [
    "assets/img/dess_1.png",
    "assets/img/dess_2.png",
    "assets/img/dess_3.png",
    "assets/img/dess_4.png",
  ];

  mObj["image"] = demoImages[index % 4];

  return MenuItemRow(
    mObj: {
      "image": mObj["image"],
      "name": mObj["Food Name"],
      "price": mObj["Price (?)"],
      "rate": "4.9",
      "rating": "100",
      "type": mObj["Category"],
      "food_type": mObj["Category"],
    },


                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ItemDetailsView()),
                    //   );
                    // },
                  // onTap: () {

//   CartService.addItem(
//     CartItem(
//       name: mObj["name"].toString(),
//       image: mObj["image"].toString(),
//       price: mObj["price"] as double,
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         "${mObj["name"]} added to cart",
//       ),
//     ),
//   );
// },

// onTap: () {

//   CartService.addItem(
//     CartItem(
//       name: mObj["Food Name"].toString(),
//       image: mObj["image"].toString(),
//       price: (mObj["Price (?)"] as num).toDouble(),
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         "${mObj["Food Name"]} added to cart",
//       ),
//     ),
//   );
// },
          onTap: () {
              Navigator.push(
             context,
              MaterialPageRoute(
                builder: (context) => ItemDetailsView(
               mObj: mObj,
               ),
              ),
                );
              }, 
                  
                    );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
