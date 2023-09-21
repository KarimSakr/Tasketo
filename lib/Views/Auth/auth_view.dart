import 'package:flutter/material.dart';
import 'package:tasketo/Utils/Enums/role.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();

  var _isLoggingIn = true;

  Role _selectedRole = Role.employee;

  final List<Role> _roles = Role.values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Tasketo"),
      ),
      body: Center(
        child: SizedBox(
          height: 550,
          width: 340,
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                        decoration: const InputDecoration(
                            icon: Icon(Icons.mail), labelText: "Email"),
                        validator: (value) {
                          // do something
                        },
                        onSaved: (value) {
                          // do something
                        },
                      ),
                      if (!_isLoggingIn)
                        TextFormField(
                          decoration: const InputDecoration(
                              icon: Icon(Icons.local_library_rounded),
                              labelText: "Full name"),
                          validator: (value) {
                            // do something
                          },
                          onSaved: (value) {
                            // do something
                          },
                        ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.lock), labelText: "Password"),
                        validator: (value) {
                          // do something
                        },
                        onSaved: (value) {
                          // do something
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
                        onPressed: () {},
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
                          child: const Text("I don't have an account."))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
