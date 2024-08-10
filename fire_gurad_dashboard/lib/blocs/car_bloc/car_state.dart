part of 'car_bloc.dart';

@immutable
sealed class CarState {}

final class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarSuccess extends CarState {
  final List<CarModel> cars;

  CarSuccess({required this.cars});
}

class CarError extends CarState {
  final String errorMessage;

  CarError({required this.errorMessage});
}
