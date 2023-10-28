import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';
import 'package:tasketo/Utils/Manager/shared_prefence_manager.dart';
import 'package:tasketo/Utils/Network/auth_manager.dart';

class AuthViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final persistence = SharedPrefrenceManager();
  final AuthManager authManager = AuthManager();

  bool isOnLoginScreen = true;
  bool isRoleSelected = false;
  bool isSubmitted = false;

  Role selectedRole = Role.role;

  final List<Role> roles = Role.values.toList();

  Future<void> submit(
      {required String enteredEmail,
      required String enteredPassword,
      required String enteredFullName}) async {
    isSubmitted = true;
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
          await authManager.signIn(enteredEmail, enteredPassword);
        } else {
          if (isRoleSelected) {
            await authManager.createUser(
                enteredEmail, enteredPassword, enteredFullName, selectedRole);
          }
        }
      } catch (error) {
        rethrow;
      }
    }
  }
}
