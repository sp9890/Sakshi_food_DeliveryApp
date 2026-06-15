import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';
import 'phone_otp_view.dart';


class PhoneLoginView extends StatefulWidget {
const PhoneLoginView({super.key});

@override
State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {
final TextEditingController txtPhone = TextEditingController();

void sendOtp() async {
  String phone = txtPhone.text.trim();

  if (phone.length != 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Enter valid mobile number")),
    );
    return;
  }

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: "+91$phone",

    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    },

    verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Verification Failed")),
      );
    },

    codeSent: (String verificationId, int? resendToken) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PhoneOtpView(
            verificationId: verificationId,
            phone: phone,
          ),
        ),
      );
    },

    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}





@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Phone Login"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          RoundTextfield(
            hintText: "Mobile Number",
            controller: txtPhone,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 20),

          RoundButton(
            title: "Send OTP",
            onPressed: sendOtp,
          ),
        ],
      ),
    ),
  );
}}