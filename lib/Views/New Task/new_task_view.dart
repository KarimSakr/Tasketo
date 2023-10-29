import 'package:flutter/material.dart';
import 'package:tasketo/Views/New%20Task/new_task_view_model.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({super.key});

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  @override
  Widget build(BuildContext context) {
    final NewTaskViewModel _viewModel = NewTaskViewModel();

    void _presentDatePicker() async {
      final now = DateTime.now();
      final lastDate = DateTime(now.year + 10, now.month, now.day);
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: lastDate,
      );
      setState(() {
        _viewModel.selectedDate = pickedDate;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _viewModel.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Column(
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter a task";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 400,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter a task";
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _viewModel.selectedDate == null
                            ? "No due date selected"
                            : _viewModel.formatter
                                .format(_viewModel.selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Add Task'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
