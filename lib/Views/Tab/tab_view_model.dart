import 'package:firebase_auth/firebase_auth.dart';

class TabViewModel {

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}