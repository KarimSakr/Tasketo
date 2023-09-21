import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Tasketo"),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 340,
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.account_circle_sharp, size: 85, 
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Submit"),
                      ),
                      TextButton(
                          onPressed: () {},
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
