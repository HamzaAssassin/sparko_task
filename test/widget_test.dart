import 'package:flutter/material.dart';
import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';
import 'package:flutter_sparko_task/domain/use_cases.dart';
import 'package:flutter_sparko_task/presentation/screen/task_list_page.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  testWidgets('TaskListScreen displays "No tasks found." initially',
      (tester) async {
    late SqfliteTaskRepository sqfliteTaskRepository = SqfliteTaskRepository();
    late GetTasks getTasks = GetTasks(sqfliteTaskRepository);
    late AddTask addTask = AddTask(sqfliteTaskRepository);
    late DeleteTask deleteTask = DeleteTask(sqfliteTaskRepository);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) =>
            TaskBlocBloc(getTasks, addTask, deleteTask)..add(FetchTaskEvent()),
        child: const MaterialApp(
          home: TaskListPage(),
        ),
      ),
    );

    await tester.pumpAndSettle(); // Allow BLoC to process events

    expect(find.text("No Task FOund"), findsOneWidget);
  });

  testWidgets('TaskListScreen displays tasks after adding', (tester) async {
    late SqfliteTaskRepository sqfliteTaskRepository = SqfliteTaskRepository();
    late GetTasks getTasks = GetTasks(sqfliteTaskRepository);
    late AddTask addTask = AddTask(sqfliteTaskRepository);
    late DeleteTask deleteTask = DeleteTask(sqfliteTaskRepository);

    await tester.pumpWidget(
      BlocProvider(
        create: (context) => TaskBlocBloc(getTasks, addTask, deleteTask)
          ..add(const AddTaskEvent(taskTitle: "Task 1")),
        child: const MaterialApp(
          home: TaskListPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text("Task 1"), findsOneWidget);
  });
}
