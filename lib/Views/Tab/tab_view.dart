import 'package:flutter/material.dart';
import 'package:tasketo/Views/Calendar/calendar_view.dart';
import 'package:tasketo/Views/New%20Task/new_task_view.dart';
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const NewTaskView()));
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
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
      ),
    );
  }
}
