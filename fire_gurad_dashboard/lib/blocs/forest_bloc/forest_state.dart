part of 'forest_bloc.dart';

@immutable
sealed class ForestState {}

final class ForestInitial extends ForestState {}

class ForestLoading extends ForestState {}

class ForestSuccess extends ForestState {
  final List<ForestModel> forests;

  ForestSuccess({required this.forests});
}

class ForestError extends ForestState {
  final String errorMessage;

  ForestError({required this.errorMessage});
}
