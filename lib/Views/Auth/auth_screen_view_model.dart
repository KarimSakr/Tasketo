import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isOnLoginScreen = true;
  bool isLoading = false;

  Role selectedRole = Role.role;

  String enteredEmail = "";
  String enteredFullName = "";
  String enteredPassword = "";

  final List<Role> roles = Role.values.toList();

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();

    if (isValid && selectedRole != Role.role) {
      formKey.currentState!.save();

      if (isOnLoginScreen) {
        final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        print(user);
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        // You can perform additional actions after user registration if needed.
      }

      // You can print or perform other actions with the entered data here.
      print(enteredEmail);
      print(enteredFullName);
      print(enteredPassword);
    }
  }
}
