import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email Address", style: TextStyle(color: Colors.white, ),),
        backgroundColor: Colors.green.shade400,
      ),
      body: Column(
        children: [
          const Text("please email verify"),
          TextButton(
              onPressed: () async{
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text("send email to verify")),
        ],
      ),
    );
  }
}