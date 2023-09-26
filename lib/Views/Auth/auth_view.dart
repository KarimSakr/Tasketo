import 'package:flutter/material.dart';
import 'package:tasketo/Views/Auth/auth_screen_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthViewModel _viewModel = AuthViewModel();

  String _enteredEmail = '';
  String _enteredFullName = '';
  String _enteredPassword = '';

  void _displayScaffold(String errorMessage) {
    ScaffoldMessenger.of(context).clearSnackBars();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

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
                      _viewModel.isOnLoginScreen ? 'Login' : 'Signup',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                        _viewModel.isOnLoginScreen
                            ? Icons.account_circle_sharp
                            : Icons.person_add_alt_1,
                        size: 85,
                        color: Theme.of(context).colorScheme.primary),
                    TextFormField(
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.mail), labelText: 'Email'),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Please enter a valid email address.';
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
                          icon: Icon(Icons.lock), labelText: 'Password'),
                      validator: (value) {
                        if (value == null) {
                          return 'Enter a valid password';
                        }
                        if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                          return 'should contain at least one upper case';
                        }
                        if (!RegExp(r'^(?=.*?[0-9])').hasMatch(value)) {
                          return 'should contain at least one digit';
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
                    if (!_viewModel.isOnLoginScreen)
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.local_library_rounded),
                            labelText: 'Full Name'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter a valid name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredFullName = value!;
                        },
                      ),
                    const SizedBox(height: 20),
                    if (!_viewModel.isOnLoginScreen)
                      DropdownButton(
                        value: _viewModel.selectedRole,
                        items: _viewModel.roles
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                child: Text(element.name),
                              ),
                            )
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
                      if (!_viewModel.isRoleSelected &&
                        !_viewModel.isOnLoginScreen &&
                        _viewModel.isSubmitted)
                      Text(
                        'Choose a role',
                        style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 11,
                        ),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      onPressed: () async {
                        setState(() {
                          _viewModel.isLoading = true;
                        });
                        try {
                          await _viewModel.submit(
                              enteredEmail: _enteredEmail,
                              enteredPassword: _enteredPassword,
                              enteredFullName: _enteredFullName);
                        } catch (error) {
                          _displayScaffold(error.toString());
                        }
                        setState(() {
                          _viewModel.isLoading = false;
                        });
                      },
                      child: _viewModel.isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Submit"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _viewModel.isOnLoginScreen =
                              !_viewModel.isOnLoginScreen;
                        });
                      },
                      child: Text(_viewModel.isOnLoginScreen
                          ? "I don't have an account."
                          : 'I already have an account.'),
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
