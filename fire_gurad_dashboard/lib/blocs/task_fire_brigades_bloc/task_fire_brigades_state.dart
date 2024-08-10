part of 'task_fire_brigades_bloc.dart';

@immutable
sealed class TaskFireBrigadesState {}

final class TaskFireBrigadesInitial extends TaskFireBrigadesState {}

class TaskFireBrigadesLoading extends TaskFireBrigadesState {}

class TaskFireBrigadesSuccess extends TaskFireBrigadesState {
  final List<TaskFireBrigadeModel> tasks;

  TaskFireBrigadesSuccess({required this.tasks});
}

class TaskFireBrigadesError extends TaskFireBrigadesState {
  final String errorMessage;

  TaskFireBrigadesError({required this.errorMessage});
}
