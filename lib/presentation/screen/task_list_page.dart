import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparko_task/presentation/screen/task_create_page.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';
import 'package:flutter_sparko_task/presentation/widgets/get_tast_widget.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: BlocBuilder<TaskBlocBloc, TaskBlocState>(
        builder: (context, state) {
          if (state is TaskBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskBlocLoaded) {
            return GetTaskWidget(
              taskList: state.taskList,
            );
          } else if (state is TaskBlocError) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
            });
            return const ErrorTaskWidget();
          } else if (state is TaskBlocEmpty) {
            return const EmptyTaskWidget();
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, TaskCreatePage.pageName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
