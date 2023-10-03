import 'package:firebase_auth/firebase_auth.dart';

class TabViewModel {
  int selectedTabIndex = 0;

  void selectPage(int index) {
    selectedTabIndex = index;
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
