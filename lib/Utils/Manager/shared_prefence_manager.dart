import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasketo/Models/user.dart';
import 'package:tasketo/Utils/constants.dart';

class SharedPrefrenceManager {
  SharedPrefrenceManager._internal();
  static final SharedPrefrenceManager _instance =
      SharedPrefrenceManager._internal();

  static SharedPrefrenceManager get instance => _instance;

  Future<void> saveUser(TasketoUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PersistenceKeys.userEmail, user.email);
    await prefs.setString(PersistenceKeys.userId, user.id);
    await prefs.setString(PersistenceKeys.userFullName, user.fullName);
    await prefs.setString(PersistenceKeys.userRole, user.role);
  }

  Future<TasketoUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString(PersistenceKeys.userEmail);
    final String? id = prefs.getString(PersistenceKeys.userId);
    final String? fullName = prefs.getString(PersistenceKeys.userFullName);
    final String? role = prefs.getString(PersistenceKeys.userRole);

    return TasketoUser(
        id: id!, email: email!, fullName: fullName!, role: role!);
  }
}
