import 'package:flutter/material.dart';
import 'package:tasketo/Models/task.dart';

class TaskCell extends StatelessWidget {
  const TaskCell({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(task.title),
          ],
        ),
      ),
    );
  }
}
