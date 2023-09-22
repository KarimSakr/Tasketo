import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();

  var _isLoggingIn = true;

  Role _selectedRole = Role.employee;
  String _enteredEmail = "";
  String _enteredFullName = "";
  String _enteredPassword = "";

  final List<Role> _roles = Role.values.toList();

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();

      if (_isLoggingIn) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final newUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
      }

      print(_enteredEmail);
      print(_enteredFullName);
      print(_enteredPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Tasketo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              margin: const EdgeInsets.all(25),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLoggingIn ? "Login" : "Signup",
                        style: const TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                          _isLoggingIn
                              ? Icons.account_circle_sharp
                              : Icons.person_add_alt_1,
                          size: 85,
                          color: Theme.of(context).colorScheme.primary),
                      TextFormField(
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.mail), labelText: "Email"),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Please enter a valid email address.";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock), labelText: "Password"),
                        validator: (value) {
                          if (value == null) {
                            return "Enter a valid password";
                          }
                          if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                            return "should contain at least one upper case";
                          }
                          if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                            return "should contain at least one digit";
                          }
                          if (!RegExp(r'^.{8,}').hasMatch(value) ||
                              value.trim().isEmpty) {
                            return "Must be at least 8 characters in length";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                      ),
                      if (!_isLoggingIn)
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.local_library_rounded),
                              labelText: "Full name"),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter a valid name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredFullName = value!;
                          },
                        ),
                      if (!_isLoggingIn)
                        DropdownButton(
                          value: _selectedRole,
                          items: _roles
                              .map((element) => DropdownMenuItem(
                                  value: element, child: Text(element.name)))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                        onPressed: _submit,
                        child: const Text("Submit"),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(
                            () {
                              _isLoggingIn = !_isLoggingIn;
                            },
                          );
                        },
                        child: Text(_isLoggingIn
                            ? "I don't have an account."
                            : "I already have an account."),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
