import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoggingIn = true;
  Role selectedRole = Role.employee;
  String enteredEmail = "";
  String enteredFullName = "";
  String enteredPassword = "";
  final List<Role> roles = Role.values.toList();

  Future<void> submit() async {
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      formKey.currentState!.save();

      if (isLoggingIn) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
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
