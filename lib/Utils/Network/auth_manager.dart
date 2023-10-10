import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasketo/Models/user.dart';
import 'package:tasketo/Utils/Enums/role.dart';
import 'package:tasketo/Utils/Manager/shared_prefence_manager.dart';

class AuthManager {
  // Private constructor
  AuthManager._privateConstructor();

  // Static instance variable
  static final AuthManager _instance = AuthManager._privateConstructor();

  // Factory constructor to return the instance
  factory AuthManager() {
    return _instance;
  }

  final persistence = SharedPrefrenceManager();

  Future<void> signIn(String enteredEmail, String enteredPassword) async {
    try {
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
    } on FirebaseAuthException catch (error) {
      throw error.code
          .toLowerCase()
          .replaceAll(RegExp(r'_'), ' ')
          .replaceAll(RegExp(r'-'), ' ');
    }
  }

  Future<void> createUser(String enteredEmail, String enteredPassword,
      String enteredFullName, Role selectedRole) async {
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
