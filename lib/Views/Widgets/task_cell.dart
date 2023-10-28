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
              if (task.color != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.circle,
                    color: task.color,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title),
                    if (task.description != null)
                      SizedBox(
                        width: 200,
                        child: Text(
                          task.description!,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      )
                  ],
                ),
              ),
              Icon(
                Icons.check_box,
                color: task.isCompleted ? Colors.green : Colors.grey,
              ),
            ],
          )),
    );
  }
}
