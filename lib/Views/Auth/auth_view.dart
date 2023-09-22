import 'package:flutter/material.dart';
import 'package:tasketo/Views/Auth/auth_screen_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthViewModel _viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _viewModel.formKey,
            child: Card(
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                      Text(
                        _viewModel.isLoggingIn ? "Login" : "Signup",
                        style: const TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                          _viewModel.isLoggingIn
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
                          _viewModel.enteredEmail = value!;
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
                          _viewModel.enteredPassword = value!;
                        },
                      ),
                      if (!_viewModel.isLoggingIn)
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
                            _viewModel.enteredFullName = value!;
                          },
                        ),
                      if (!_viewModel.isLoggingIn)
                        DropdownButton(
                          value: _viewModel.selectedRole,
                          items: _viewModel.roles
                              .map((element) => DropdownMenuItem(
                                  value: element, child: Text(element.name)))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _viewModel.selectedRole = value;
                            });
                          },
                        ),
                      const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: _viewModel.submit,
                      child: const Text("Submit"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _viewModel.isLoggingIn = !_viewModel.isLoggingIn;
                        });
                      },
                      child: Text(_viewModel.isLoggingIn
                          ? "I don't have an account."
                          : "I already have an account."),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
