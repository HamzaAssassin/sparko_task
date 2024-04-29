import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';
import 'package:flutter_sparko_task/domain/use_cases.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Use Cases', () {
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

    test('GetTasks returns an empty list initially', () async {
      final tasks = await getTasks.call();
      expect(tasks, isEmpty);
    });

    test('AddTask adds a new task', () async {
      await addTask.call('New Task');
      final tasks = await getTasks();
      expect(tasks.length, 1);
      expect(tasks.first.name, 'New Task');
    });

    test('DeleteTask deletes a task', () async {
      await addTask('Task to Delete');
      var tasks = await getTasks();
      expect(tasks.length, 1);

      await deleteTask.call(tasks.first.id!);
      tasks = await getTasks();
      expect(tasks, isEmpty);
    });
  });
}
