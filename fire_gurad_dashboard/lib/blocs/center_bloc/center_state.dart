part of 'center_bloc.dart';

@immutable
sealed class CenterState {}

final class CenterInitial extends CenterState {}

class CenterLoading extends CenterState {}

class CenterSuccess extends CenterState {
  final List<CenterModel> centers;

  CenterSuccess({required this.centers});

}

class CenterError extends CenterState {
  final String errorMessage;

  CenterError({required this.errorMessage});

}
