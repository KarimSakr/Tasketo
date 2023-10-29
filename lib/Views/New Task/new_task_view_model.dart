import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final formatter = DateFormat.yMd();
  DateTime? selectedDate;
}
