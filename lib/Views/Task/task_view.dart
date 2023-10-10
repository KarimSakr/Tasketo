import 'package:flutter/material.dart';
import 'package:tasketo/Models/task.dart';
import 'package:tasketo/Models/user.dart';
import 'package:tasketo/Views/Widgets/task_cell.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  List<Task> tasks = [
    Task(
      id: "4234234",
      title: 'test',
      description: 'test test',
      assignedUser: TasketoUser(
          id: '', email: 'email', fullName: 'Karim Sakr', role: 'role'),
      assignedDate: DateTime.now(),
      dueDate: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCell(task: tasks[index],);
        });
  }
}
