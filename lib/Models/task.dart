import 'package:tasketo/Models/user.dart';
import 'package:tasketo/Utils/Enums/tag.dart';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedUser,
    required this.assignedDate,
    required this.dueDate,
    required this.tag,
  });

  final String id;
  final String title;
  final String description;
  final TasketoUser assignedUser;
  final DateTime assignedDate;
  final DateTime dueDate;
  final Tag tag;
}
