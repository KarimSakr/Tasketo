import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasketo/Models/user.dart';
import 'package:tasketo/Utils/Enums/role.dart';
import 'package:tasketo/Utils/Manager/shared_prefence_manager.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final persistence = SharedPrefrenceManager();

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
          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .get()
              .then((DocumentSnapshot doc) async {
            if (doc.exists) {
              final data = doc.data() as Map<String, String>;

              await persistence.saveUser(TasketoUser(
                  id: userCredential.user!.uid,
                  email: data['email']!,
                  fullName: data['fullName']!,
                  role: data['role']!));
            }
          });
        } else {
          if (isRoleSelected) {
            final userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: enteredEmail,
              password: enteredPassword,
            );

            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'fullName': enteredFullName,
              'email': enteredEmail,
              'role': selectedRole.name,
            });

            await persistence.saveUser(TasketoUser(
                id: userCredential.user!.uid,
                email: enteredEmail,
                fullName: enteredFullName,
                role: selectedRole.name));
          }
        }
      } on FirebaseAuthException catch (error) {
        throw error.code
            .toLowerCase()
            .replaceAll(RegExp(r'_'), ' ')
            .replaceAll(RegExp(r'-'), ' ');
      }
    }
  }
}
