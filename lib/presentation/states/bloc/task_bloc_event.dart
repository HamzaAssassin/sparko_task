part of 'task_bloc_bloc.dart';

sealed class TaskBlocEvent extends Equatable {
  const TaskBlocEvent();

  @override
  List<Object> get props => [];
}

@immutable
class FetchTaskEvent extends TaskBlocEvent {}

@immutable
class DeleteTaskEvent extends TaskBlocEvent {
  final int taskId;

  const DeleteTaskEvent({required this.taskId});
}

@immutable
class AddTaskEvent extends TaskBlocEvent {
  final String taskTitle;

  const AddTaskEvent({required this.taskTitle});
}

// @immutable
// class RefreshStateEvent extends TaskBlocEvent {}
