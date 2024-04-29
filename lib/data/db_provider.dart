import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static const String databaseName = "task_db.db";
  static Future<Database> get database async {
    var databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return _database ??= await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(SqfliteTaskRepository.createTable);
      },
      version: 1,
    );
  }
}
