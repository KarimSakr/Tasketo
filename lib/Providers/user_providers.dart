import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasketo/Models/user.dart';

class UserNotifier extends StateNotifier<TasketoUser> {
  UserNotifier()
      : super(TasketoUser(id: "", email: "", fullName: "", role: ""));

  Future<void> fetchUser({required String id}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((DocumentSnapshot doc) {
      if (!doc.exists) {
        throw "Fail to login, try again.";
      } else {
        final data = doc.data() as Map<String, String>;
        state = TasketoUser(
            id: data["id"]!,
            email: data["email"]!,
            fullName: data["fullName"]!,
            role: data["id"]!);
      }
    });
  }
}

final currentUser = StateNotifierProvider<UserNotifier, TasketoUser>(
  (ref) => UserNotifier(),
);
