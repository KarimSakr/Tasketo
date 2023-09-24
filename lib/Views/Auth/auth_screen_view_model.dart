import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isOnLoginScreen = true;
  bool isLoading = false;
  bool isRoleSelected = false;

  Role selectedRole = Role.role;



  final List<Role> roles = Role.values.toList();

  Future<void> submit({required String enteredEmail, required String enteredPassword, required enteredFullName}) async {
    final isValid = formKey.currentState!.validate();
    if (selectedRole != Role.role) {
      isRoleSelected = true;
    }

    if (isValid) {
      formKey.currentState!.save();

      try {
        if (isOnLoginScreen) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );
        } else {
          if (isRoleSelected) {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: enteredEmail,
              password: enteredPassword,
            );
          }
        }
      } on FirebaseAuthException catch (error) {
        throw error.code.toLowerCase().replaceAll(RegExp(r'_'), " ");
      }
    }
  }
}
