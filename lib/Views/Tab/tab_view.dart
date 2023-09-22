import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      child: const Text("logout"),
    );
  }
}
