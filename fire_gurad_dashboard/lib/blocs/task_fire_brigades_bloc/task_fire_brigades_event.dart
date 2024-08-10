part of 'task_fire_brigades_bloc.dart';

@immutable
sealed class TaskFireBrigadesEvent {}

class FetchTaskFireBrigades extends TaskFireBrigadesEvent {}