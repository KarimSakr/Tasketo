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
        title: 'Task 1',
        description: 'This is the description of the task.',
        isCompleted: true,
        assignedUser: TasketoUser(
            id: '', email: 'email', fullName: 'Karim Sakr', role: 'role'),
        assignedDate: DateTime.now(),
        dueDate: DateTime.now(),
        color: Colors.red)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskCell(
            task: tasks[index],
          );
        });
  }
}
