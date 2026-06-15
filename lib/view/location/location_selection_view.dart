import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationSelectionView extends StatefulWidget {
  const LocationSelectionView({super.key});



  @override
  State<LocationSelectionView> createState() =>
      _LocationSelectionViewState();
}

class _LocationSelectionViewState
    extends State<LocationSelectionView> {

  TextEditingController searchController =
      TextEditingController();

        String currentLocation = "Detecting location...";

          @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {

    Position position =
        await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    setState(() {
      currentLocation =
          "${place.locality}, ${place.administrativeArea}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                      ),
                    ),

                    const Text(
                      "Select a location",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.green,
                        size: 32,
                      ),
                      hintText:
                          "Search for area, street name...",
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [

                      ListTile(
                        leading: const Icon(
                          Icons.my_location,
                          color: Colors.green,
                          size: 32,
                        ),
                        title: const Text(
                          "Use current location",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                        subtitle: 
                        Text(currentLocation),
                        trailing: const Icon(
                          Icons.chevron_right,
                        ),
                        // onTap: () {},

onTap: () async {

  SharedPreferences prefs =
      await SharedPreferences.getInstance();

  await prefs.setString(
    "user_location",
    currentLocation,
  );

  Navigator.pop(context);
},


                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 32,
                        ),
                        title: const Text(
                          "Add Address",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "SAVED ADDRESSES",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                buildAddressCard(
                  "Home",
                  "CIDCO, Aurangabad",
                ),

                const SizedBox(height: 20),

                buildAddressCard(
                  "Office",
                  "Waluj MIDC",
                ),

                const SizedBox(height: 30),

                const Text(
                  "RECENT LOCATIONS",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding:
                      const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [

                      Icon(Icons.history),

                      SizedBox(width: 15),

                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aurangabad",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          Text("Maharashtra"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAddressCard(
      String title,
      String address) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          const Icon(
            Icons.home_outlined,
            size: 35,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(address),
              ],
            ),
          ),
        ],
      ),
    );
  }
}