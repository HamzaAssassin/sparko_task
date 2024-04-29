// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_sparko_task/data/sqflite_task_repositories.dart';

class Task {
  final int? id;
  final String name;
  Task({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map[SqfliteTaskRepository.keyTaskId] as int,
      name: map[SqfliteTaskRepository.keyName] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(id: $id, name: $name)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
