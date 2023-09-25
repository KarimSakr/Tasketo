import 'package:tasketo/Utils/Enums/role.dart';

class TasketoUser {
  TasketoUser(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.role});
  final String id;
  final String email;
  final String fullName;
  final Role role;
}
