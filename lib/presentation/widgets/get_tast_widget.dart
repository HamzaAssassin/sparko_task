import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparko_task/domain/task.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';

class GetTaskWidget extends StatelessWidget {
  const GetTaskWidget({super.key, required this.taskList});
  final List<Task> taskList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taskList[index].name),
          trailing: IconButton(
              onPressed: () {
                context
                    .read<TaskBlocBloc>()
                    .add(DeleteTaskEvent(taskId: taskList[index].id!));
              },
              icon: const Icon(Icons.delete_rounded)),
        );
      },
    );
  }
}

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Task Found"),
    );
  }
}

class ErrorTaskWidget extends StatelessWidget {
  const ErrorTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          onPressed: () {
            context.read<TaskBlocBloc>().add(FetchTaskEvent());
          },
          icon: const Icon(
            Icons.refresh,
            size: 50,
          )),
    );
  }
}
