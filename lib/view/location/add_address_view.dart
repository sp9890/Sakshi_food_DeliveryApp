import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {

  String selectedType = "Home";

  final txtHouseNo = TextEditingController();
  final txtBuilding = TextEditingController();
  final txtLandmark = TextEditingController();
  final txtAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
     body: SingleChildScrollView(
  padding: const EdgeInsets.all(20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const Text(
        "Address Type",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 15),

      Row(
        children: [

          ChoiceChip(
            label: const Text("Home"),
            selected: selectedType == "Home",
            onSelected: (value) {
              setState(() {
                selectedType = "Home";
              });
            },
          ),

          const SizedBox(width: 10),

          ChoiceChip(
            label: const Text("Office"),
            selected: selectedType == "Office",
            onSelected: (value) {
              setState(() {
                selectedType = "Office";
              });
            },
          ),

          const SizedBox(width: 10),

          ChoiceChip(
            label: const Text("Other"),
            selected: selectedType == "Other",
            onSelected: (value) {
              setState(() {
                selectedType = "Other";
              });
            },
          ),
        ],
      ),

      const SizedBox(height: 25),

      TextField(
        controller: txtHouseNo,
        decoration: const InputDecoration(
          labelText: "House / Flat No",
          border: OutlineInputBorder(),
        ),
      ),

      const SizedBox(height: 15),

      TextField(
        controller: txtBuilding,
        decoration: const InputDecoration(
          labelText: "Building Name",
          border: OutlineInputBorder(),
        ),
      ),

      const SizedBox(height: 15),

      TextField(
        controller: txtLandmark,
        decoration: const InputDecoration(
          labelText: "Landmark",
          border: OutlineInputBorder(),
        ),
      ),

      const SizedBox(height: 15),

      TextField(
        controller: txtAddress,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: "Full Address",
          border: OutlineInputBorder(),
        ),
      ),

      const SizedBox(height: 30),

      SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () async {



            if (txtHouseNo.text.trim().isEmpty ||
               txtBuilding.text.trim().isEmpty ||
              txtAddress.text.trim().isEmpty) {

             ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text(
                        "Please fill all required fields",
                ),
                   ),
                );

                return;
                   }

         SharedPreferences prefs =
      await SharedPreferences.getInstance();

       List<String> addressList =
          prefs.getStringList("saved_addresses") ?? [];

             String addressData =
                 "$selectedType|${txtHouseNo.text}|${txtBuilding.text}|${txtLandmark.text}|${txtAddress.text}";

              addressList.add(addressData);

               await prefs.setStringList(
                   "saved_addresses",
                 addressList,
                 );

              ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                       content: Text("Address Saved"),
                    ),
                 );

               Navigator.pop(context);
                },

          
          child: const Text(
            "Save Address",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    ],
  ),
),
    );
  }
}