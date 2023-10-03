import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Views/Splash/splash_view.dart';

class TabViewModel {
  int selectedTabIndex = 0;

  void selectPage(int index) {
    selectedTabIndex = index;
  }

  void setScreen(String identifier, BuildContext context) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push(
        MaterialPageRoute(
          // remove SplashView
          builder: ((context) => const SplashView()),
        ),
      );
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
