import 'package:flutter/material.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../location/location_permission_view.dart';


class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StarupViewState();
}

class _StarupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    goWelcomePage();
  }

  void goWelcomePage() async {

      await Future.delayed( const Duration(seconds: 5) );
      welcomePage();
  }
  // void welcomePage(){
  //   // Bypass login system for now: always go to the main app.
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const MainTabView()),
  //   );
  // }

Future<void> welcomePage() async {

  SharedPreferences prefs =
      await SharedPreferences.getInstance();

  bool locationSetupDone =
      prefs.getBool("location_setup_done") ?? false;

      print("location_setup_done = $locationSetupDone");

  if (locationSetupDone) {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainTabView(),
      ),
    );

  } else {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const LocationPermissionView(),
      ),
    );

  }
}

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

  Image.asset(
    "assets/img/splash_bg_new.png",
    width: media.width,
    height: media.height,
    fit: BoxFit.cover,
  ),

  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Image.asset(
        "assets/img/app_logo.png",
        width: media.width * 0.55,
      ),

      const SizedBox(height: 120),

      const CircularProgressIndicator(
        color: Color(0xff2E7D32),
        strokeWidth: 3,
      ),

      const SizedBox(height: 15),

      const Text(
        "Preparing your experience...",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  ),

  const Positioned(
    bottom: 40,
    left: 0,
    right: 0,
    child: Column(
      children: [

        Text(
          "Created by",
          style: TextStyle(
            color: Color(0xff2E7D32),
            fontSize: 14,
          ),
        ),

        SizedBox(height: 5),

        Text(
          "Sakshi Patankar",
          style: TextStyle(
            color: Color(0xff2E7D32),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
],
        // children: [
        //   Image.asset(
        //     "assets/img/splash_bg_new.png",
        //     width: media.width,
        //     height: media.height,
        //     fit: BoxFit.cover,
        //   ),
        //   Image.asset(
        //     "assets/img/app_logo.png",
        //      width: media.width * 0.55,
        //     height: media.width * 0.55,
        //     fit: BoxFit.contain,
        //   ),
        // ],
      ),
    );
  }
}
