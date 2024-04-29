import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';
import 'package:flutter_sparko_task/domain/use_cases.dart';
import 'package:flutter_sparko_task/presentation/screen/task_create_page.dart';
import 'package:flutter_sparko_task/presentation/screen/task_list_page.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';

void main() {
  final sqfliteTaskRepository = SqfliteTaskRepository();
  final getTasks = GetTasks(sqfliteTaskRepository);
  final addTask = AddTask(sqfliteTaskRepository);
  final deleteTask = DeleteTask(sqfliteTaskRepository);
  runApp(
    BlocProvider(
      create: (context) =>
          TaskBlocBloc(getTasks, addTask, deleteTask)..add(FetchTaskEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListPage(),
        TaskCreatePage.pageName: (context) => TaskCreatePage(),
      },
    );
  }
}
