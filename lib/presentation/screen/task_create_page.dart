import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';

class TaskCreatePage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  static const pageName = "/createTask";
  TaskCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  labelText: "Task Title", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final taskTitle = controller.text;
                if (taskTitle.isNotEmpty) {
                  context.read<TaskBlocBloc>().add(
                        AddTaskEvent(taskTitle: taskTitle),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
