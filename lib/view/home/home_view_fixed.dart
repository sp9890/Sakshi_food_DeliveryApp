import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common_widget/round_textfield.dart';

import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../common_widget/category_cell.dart';
import '../../common_widget/most_popular_cell.dart';
import '../../common_widget/popular_resutaurant_row.dart';
import '../../common_widget/recent_item_row.dart';
import '../../common_widget/view_all_title_row.dart';
import '../location/location_selection_view.dart';
import '../more/my_order_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController txtSearch = TextEditingController();

  String currentLocation = 'Current Location';

  // Used by the UI below
  final List catArr = [
    {'image': 'assets/img/cat_offer.png', 'name': 'Breakfast'},
    {'image': 'assets/img/cat_sri.png', 'name': 'Snacks'},
    {'image': 'assets/img/cat_3.png', 'name': 'Soups'},
    {'image': 'assets/img/cat_4.png', 'name': 'Pizza'},
    {'image': 'assets/img/cat_offer.png', 'name': 'Punjabi'},
    {'image': 'assets/img/cat_sri.png', 'name': 'Chinese'},
    {'image': 'assets/img/cat_3.png', 'name': 'Rice'},
    {'image': 'assets/img/cat_4.png', 'name': 'Beverages'},
  ];

  final List popArr = [
    {
      'image': 'assets/img/res_1.png',
      'name': 'Krushlila Pure Veg',
      'rate': '4.8',
      'rating': '250',
      'type': 'Restaurant',
      'food_type': 'Pure Veg',
    }
  ];

  final List mostPopArr = [
    {
      'image': 'assets/img/m_res_1.png',
      'name': 'Paneer Butter Masala',
      'rate': '4.9',
      'rating': '150',
      'type': 'Punjabi',
      'food_type': 'Veg',
    },
    {
      'image': 'assets/img/m_res_2.png',
      'name': 'Veg Biryani',
      'rate': '4.8',
      'rating': '120',
      'type': 'Rice',
      'food_type': 'Veg',
    },
  ];

  final List recentArr = [
    {
      'image': 'assets/img/item_1.png',
      'name': 'Tomato Soup',
      'rate': '4.8',
      'rating': '80',
      'type': 'Soup',
      'food_type': 'Veg',
    },
    {
      'image': 'assets/img/item_2.png',
      'name': 'Paneer Tikka',
      'rate': '4.9',
      'rating': '100',
      'type': 'Starter',
      'food_type': 'Veg',
    },
    {
      'image': 'assets/img/item_3.png',
      'name': 'Masala Dosa',
      'rate': '4.9',
      'rating': '200',
      'type': 'South Indian',
      'food_type': 'Veg',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  Future<void> loadLocation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      currentLocation = prefs.getString('user_location') ?? 'Current Location';
    });
  }

  @override
  void dispose() {
    txtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello ${ServiceCall.userPayload[KKey.name] ?? ''}!',
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyOrderView(),
                          ),
                        );
                      },
                      icon: Image.asset(
                        'assets/img/shopping_cart.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivering to',
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LocationSelectionView(),
                              ),
                            );

                            // Uncomment if LocationSelectionView sets prefs and you want instant refresh
                            // loadLocation();
                          },
                          child: Text(
                            currentLocation,
                            style: TextStyle(
                              color: TColor.secondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Image.asset(
                          'assets/img/dropdown.png',
                          width: 12,
                          height: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  hintText: 'Search Food',
                  controller: txtSearch,
                  left: Container(
                    alignment: Alignment.center,
                    width: 30,
                    child: Image.asset(
                      'assets/img/search.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: catArr.length,
                  itemBuilder: (context, index) {
                    final Map cObj = catArr[index] as Map? ?? {};
                    return CategoryCell(
                      cObj: cObj,
                      onTap: () {},
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: 'Popular Restaurants',
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: popArr.length,
                itemBuilder: (context, index) {
                  final Map pObj = popArr[index] as Map? ?? {};
                  return PopularRestaurantRow(
                    pObj: pObj,
                    onTap: () {},
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: 'Most Popular',
                  onView: () {},
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: mostPopArr.length,
                  itemBuilder: (context, index) {
                    final Map mObj = mostPopArr[index] as Map? ?? {};
                    return MostPopularCell(
                      mObj: mObj,
                      onTap: () {},
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: 'Recent Items',
                  onView: () {},
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: recentArr.length,
                itemBuilder: (context, index) {
                  final Map rObj = recentArr[index] as Map? ?? {};
                  return RecentItemRow(
                    rObj: rObj,
                    onTap: () {},
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

