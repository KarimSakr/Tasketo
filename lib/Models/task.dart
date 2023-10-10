import 'package:flutter/material.dart';
import 'package:tasketo/Models/user.dart';

class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.assignedUser,
    required this.assignedDate,
    required this.dueDate,
    this.color,
  });

  final String id;
  final String title;
  final String? description;
  final TasketoUser? assignedUser;
  final DateTime assignedDate;
  final DateTime dueDate;
  final Color? color;
}
