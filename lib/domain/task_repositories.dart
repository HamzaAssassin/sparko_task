import 'package:flutter_sparko_task/domain/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<bool> addTask(String taskTitle);
  Future<bool> deleteTask(int taskId);
}
