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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: viewModel.selectedTabIndex,
          onTap: (index) {
            setState(() {
              viewModel.selectPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
          ],
        ));
  }
}
