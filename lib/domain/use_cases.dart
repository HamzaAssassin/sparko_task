import 'package:flutter_sparko_task/domain/task.dart';
import 'package:flutter_sparko_task/domain/task_repositories.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<bool> call(String taskTitle) {
    return repository.addTask(taskTitle);
  }
}

class DeleteTask {
  final TaskRepository repository;

  DeleteTask(this.repository);

  Future<bool> call(int taskId) {
    return repository.deleteTask(taskId);
  }
}
