import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';
import 'package:flutter_sparko_task/domain/task.dart';
import 'package:flutter_sparko_task/domain/use_cases.dart';
import 'package:flutter_sparko_task/presentation/states/bloc/task_bloc_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('TaskBloc', () {
    late SqfliteTaskRepository sqfliteTaskRepository = SqfliteTaskRepository();
    late GetTasks getTasks = GetTasks(sqfliteTaskRepository);
    late AddTask addTask = AddTask(sqfliteTaskRepository);
    late DeleteTask deleteTask = DeleteTask(sqfliteTaskRepository);

    setUp(() {
      sqfliteTaskRepository = SqfliteTaskRepository();
      getTasks = GetTasks(sqfliteTaskRepository);
      addTask = AddTask(sqfliteTaskRepository);
      deleteTask = DeleteTask(sqfliteTaskRepository);
    });

    blocTest<TaskBlocBloc, TaskBlocState>(
      'emits TaskLoaded with an empty list on FetchTasks',
      build: () {
        return TaskBlocBloc(getTasks, addTask, deleteTask);
      },
      act: (bloc) => bloc.add(FetchTaskEvent()),
      expect: () => [
        TaskBlocLoading(),
        const TaskBlocLoaded(taskList: []),
      ],
    );

    blocTest<TaskBlocBloc, TaskBlocState>(
      'emits TaskLoaded with one task after CreateTask',
      build: () => TaskBlocBloc(getTasks, addTask, deleteTask),
      act: (bloc) {
        bloc.add(const AddTaskEvent(taskTitle: "New Task"));
        bloc.add(FetchTaskEvent());
      },
      expect: () => [
        TaskBlocLoading(),
        const TaskBlocLoaded(taskList: []),
        TaskBlocLoading(),
        TaskBlocLoaded(taskList: [Task(name: "New Task")]),
      ],
    );

    blocTest<TaskBlocBloc, TaskBlocState>(
      'emits TaskLoaded with no tasks after DeleteTaskEvent',
      build: () => TaskBlocBloc(getTasks, addTask, deleteTask),
      act: (bloc) {
        bloc.add(const AddTaskEvent(taskTitle: "New Task"));
        bloc.add(FetchTaskEvent());
        bloc.add(const DeleteTaskEvent(taskId: 1));
        bloc.add(FetchTaskEvent());
      },
      expect: () => [
        TaskBlocLoading(),
        const TaskBlocLoaded(taskList: []),
        TaskBlocLoading(),
        TaskBlocLoaded(taskList: [Task(id: 1, name: "New Task")]),
        TaskBlocLoading(),
        const TaskBlocLoaded(taskList: []),
      ],
    );
  });
}
