import 'dart:async';
import 'package:flutter_sparko_task/data/db_provider.dart';
import 'package:flutter_sparko_task/domain/task.dart';
import 'package:flutter_sparko_task/domain/task_repositories.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteTaskRepository implements TaskRepository {
  static const tableName = 'Task';
  static const keyTaskId = 'taskId';
  static const keyName = 'taskName';

  static const createTable =
      'CREATE TABLE $tableName($keyTaskId INTEGER PRIMARY KEY AUTOINCREMENT,$keyName TEXT NOT NULL)';
  static const dropTable = 'DROP TABLE IF EXIST $tableName';

  @override
  Future<List<Task>> getTasks() async {
    Database database = await DBProvider.database;
    var listMap = await database.query(tableName);
    return listMap.map((map) => Task.fromMap(map)).toList();
  }

  @override
  Future<bool> addTask(String taskTitle) async {
    Database database = await DBProvider.database;
    var rowId = await database.insert(
      tableName,
      <String, dynamic>{
        keyName: taskTitle,
      },
    );
    return rowId > 0;
  }

  @override
  Future<bool> deleteTask(int taskId) async {
    Database database = await DBProvider.database;
    var rowId = await database.delete(tableName,
        where: '${SqfliteTaskRepository.keyTaskId}=?', whereArgs: [taskId]);
    return rowId > 0;
  }
}
