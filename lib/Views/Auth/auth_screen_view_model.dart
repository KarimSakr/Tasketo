import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isOnLoginScreen = true;
  bool isLoading = false;
  bool isRoleSelected = false;
  bool didErrorOccur = false;

  Role selectedRole = Role.role;

  String enteredEmail = "";
  String enteredFullName = "";
  String enteredPassword = "";
  String errorMessage = "";

  final List<Role> roles = Role.values.toList();

  Future<void> submit() async {
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
        didErrorOccur = true;
        errorMessage = error.code.toLowerCase().replaceAll(RegExp(r'_'), " ");
        throw errorMessage;
      }
    }
  }

  void diplaySnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }
}
