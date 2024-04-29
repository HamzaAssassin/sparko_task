import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparko_task/domain/task.dart';
import 'package:flutter_sparko_task/domain/use_cases.dart';

part 'task_bloc_event.dart';
part 'task_bloc_state.dart';

class TaskBlocBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final DeleteTask deleteTask;
  TaskBlocBloc(this.getTasks, this.addTask, this.deleteTask)
      : super(TaskBlocLoading()) {
    on<FetchTaskEvent>(getTaskList);
    on<AddTaskEvent>(addTaskBloc);
    on<DeleteTaskEvent>(deleteTaskBloc);
    // on<RefreshStateEvent>(refreshStateBloc);
  }

  FutureOr<void> getTaskList(
      FetchTaskEvent event, Emitter<TaskBlocState> emit) async {
    try {
      emit.call(TaskBlocLoading());
      List<Task> taskList = await getTasks.call();
      if (taskList.isEmpty) {
        emit.call(TaskBlocEmpty());
      } else {
        emit.call(TaskBlocLoaded(taskList: taskList));
      }
    } catch (e) {
      emit.call(TaskBlocError(error: e.toString()));
    }
  }

  FutureOr<void> addTaskBloc(
      AddTaskEvent event, Emitter<TaskBlocState> emit) async {
    try {
      bool isAdded = await addTask.call(event.taskTitle);
      if (isAdded) {
        add(FetchTaskEvent());
      } else {
        emit.call(const TaskBlocError(error: "Task Not Added"));
      }
    } catch (e) {
      emit.call(TaskBlocError(error: e.toString()));
    }
  }

  FutureOr<void> deleteTaskBloc(
      DeleteTaskEvent event, Emitter<TaskBlocState> emit) async {
    try {
      bool isDeleted = await deleteTask.call(event.taskId);
      if (isDeleted) {
        add(FetchTaskEvent());
      } else {
        emit.call(const TaskBlocError(error: "Task Not Deleted"));
      }
    } catch (e) {
      emit.call(TaskBlocError(error: e.toString()));
    }
  }

  // FutureOr<void> refreshStateBloc(
  //     RefreshStateEvent event, Emitter<TaskBlocState> emit) {
  //   emit.call(TaskBlocLoading());
  // }
}
