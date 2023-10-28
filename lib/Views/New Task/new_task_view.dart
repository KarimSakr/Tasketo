import 'package:flutter/material.dart';

class NewTaskView extends StatelessWidget {
  const NewTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(child: Text('New Task')),
    );
  }
}
