part of 'task_bloc_bloc.dart';

sealed class TaskBlocState extends Equatable {
  const TaskBlocState();

  @override
  List<Object> get props => [];
}

final class TaskBlocInitial extends TaskBlocState {}

final class TaskBlocLoading extends TaskBlocState {}

final class TaskBlocLoaded extends TaskBlocState {
  final List<Task> taskList;

  const TaskBlocLoaded({required this.taskList});
}

@immutable
class TaskBlocEmpty extends TaskBlocState {}

final class TaskBlocError extends TaskBlocState {
  final String error;

  const TaskBlocError({required this.error});
}
