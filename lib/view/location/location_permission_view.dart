import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; 

import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_delivery/view/main_tabview/main_tabview.dart';

class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({super.key});

  @override
  State<LocationPermissionView> createState() =>
      _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> {

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

   Position position = await Geolocator.getCurrentPosition(
  locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
  ),
);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    // print("${place.locality}, ${place.administrativeArea}");

    String currentLocation =
    "${place.locality}, ${place.administrativeArea}";

SharedPreferences prefs =
    await SharedPreferences.getInstance();


await prefs.setBool(
  "location_setup_done",
  true,
);

await prefs.setString(
  "user_location",
  currentLocation,
);


print(currentLocation);

Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => const MainTabView(),
  ),
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [

              const SizedBox(height: 40),

              const Text(
                "Set Your Delivery Location",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff2D2D2D),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Enjoy fresh, hygienic and pure vegetarian food from Krushnlila near you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: Image.asset(
                  "assets/img/location_map.png",
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  //onPressed: () {},
                  onPressed: getCurrentLocation,
                  icon: const Icon(Icons.location_on,color: Colors.white),
                  label: const Text(
                    "Enable Device Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6B00),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xffFF6B00),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Enter Location Manually",
                    style: TextStyle(
                      color: Color(0xffFF6B00),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip for now",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}