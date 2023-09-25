import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> submit(
      {required String enteredEmail,
      required String enteredPassword,
      required String enteredFullName}) async {
    final isValid = formKey.currentState!.validate();

    if (selectedRole != Role.role) {
      isRoleSelected = true;
    } else {
      isRoleSelected = false;
    }

    if (isValid) {
      formKey.currentState!.save();

      try {
        if (isOnLoginScreen) {
          // TODO: Fetch user's data on sign in
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );
        } else {
          if (isRoleSelected) {
            final userCrentials =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: enteredEmail,
              password: enteredPassword,
            );

            await FirebaseFirestore.instance
                .collection("users")
                .doc(userCrentials.user!.uid)
                .set({
              "enteredFullName": enteredFullName,
              "email": enteredEmail,
              "role": selectedRole.name,
            });
          }
        }
      } on FirebaseAuthException catch (error) {
        throw error.code
            .toLowerCase()
            .replaceAll(RegExp(r'_'), " ")
            .replaceAll(RegExp(r'-'), " ");
      }
    }
  }
}
