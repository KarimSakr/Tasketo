import 'package:flutter/material.dart';
import 'package:tasketo/Views/Splash/splash_view.dart';
import 'package:tasketo/Views/Tab/tab_view_model.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final viewModel = TabViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: viewModel.signout,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(child: SplashView()),
    );
  }
}
