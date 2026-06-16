import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_textfield.dart';
import '../more/my_order_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtMobile = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

  Future<void> saveProfileImagePath() async {
    if (image == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', image!.path);
  }

  Future<void> loadProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');

    if (savedPath != null && mounted) {
      setState(() {
        image = XFile(savedPath);
      });
    }
  }

  Future<void> saveProfile() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('customer_profile')
        .set({
      'name': txtName.text.trim(),
      'email': txtEmail.text.trim(),
      'phone': txtMobile.text.trim(),
      'address': txtAddress.text.trim(),
      'role': 'customer',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile Saved Successfully'),
      ),
    );
  }

  Future<void> loadProfile() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc('customer_profile')
        .get();

    if (!doc.exists || !mounted) return;

    final data = doc.data()!;
    setState(() {
      txtName.text = data['name'] ?? '';
      txtEmail.text = data['email'] ?? '';
      txtMobile.text = data['phone'] ?? '';
      txtAddress.text = data['address'] ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
    loadProfileImagePath();
  }

  @override
  void dispose() {
    txtName.dispose();
    txtEmail.dispose();
    txtMobile.dispose();
    txtAddress.dispose();
    txtPassword.dispose();
    txtConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
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
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: TColor.placeholder,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(image!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 65,
                        color: TColor.secondaryText,
                      ),
              ),
              TextButton.icon(
                onPressed: () async {
                  image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (!mounted) return;
                  setState(() {});
                  await saveProfileImagePath();
                },
                icon: Icon(
                  Icons.edit,
                  color: TColor.primary,
                  size: 12,
                ),
                label: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: TColor.primary,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                'Hi there Emilia!',
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: TColor.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Name',
                  hintText: 'Enter Name',
                  controller: txtName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Email',
                  hintText: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                  controller: txtEmail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Mobile No',
                  hintText: 'Enter Mobile No',
                  controller: txtMobile,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Address',
                  hintText: 'Enter Address',
                  controller: txtAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Password',
                  hintText: '* * * * * *',
                  obscureText: true,
                  controller: txtPassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: RoundTitleTextfield(
                  title: 'Confirm Password',
                  hintText: '* * * * * *',
                  obscureText: true,
                  controller: txtConfirmPassword,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButton(
                  title: 'Save',
                  onPressed: () async {
                    await saveProfile();
                    await saveProfileImagePath();
                  },
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

