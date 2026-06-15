import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneOtpView extends StatefulWidget {
final String verificationId;
final String phone;

const PhoneOtpView({
super.key,
required this.verificationId,
required this.phone,
});

@override
State<PhoneOtpView> createState() => _PhoneOtpViewState();
}

class _PhoneOtpViewState extends State<PhoneOtpView> {
final TextEditingController otpController = TextEditingController();

Future<void> verifyOtp() async {
try {
PhoneAuthCredential credential =
PhoneAuthProvider.credential(
verificationId: widget.verificationId,
smsCode: otpController.text.trim(),
);


  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
    credential,
  );

  String uid = userCredential.user!.uid;

  await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .set({
    "uid": uid,
    "phone": widget.phone,
    "createdAt": FieldValue.serverTimestamp(),
    "role": "customer",
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Login Successful"),
    ),
  );

  // TODO:
  // Replace with your actual home screen
  Navigator.popUntil(context, (route) => route.isFirst);

} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Invalid OTP: $e"),
    ),
  );
}


}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Verify OTP"),
),
body: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
Text(
"OTP sent to +91${widget.phone}",
),


        const SizedBox(height: 20),

        TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Enter OTP",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: verifyOtp,
          child: const Text("Verify OTP"),
        ),
      ],
    ),
  ),
);


}
}
