import 'package:flutter/material.dart';
import 'package:tasketo/Views/Calendar/calendar_view.dart';
import 'package:tasketo/Views/Splash/splash_view.dart';
import 'package:tasketo/Views/Tab/tab_view_model.dart';
import 'package:tasketo/Views/Task/task_view.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final viewModel = TabViewModel();
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const TaskView();

    if (viewModel.selectedTabIndex == 1) {
      activeScreen = const CalendarView();
    }

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
        body: activeScreen,
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
