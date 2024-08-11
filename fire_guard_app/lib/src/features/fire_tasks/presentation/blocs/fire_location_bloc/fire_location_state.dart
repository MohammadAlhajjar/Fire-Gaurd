part of 'fire_location_bloc.dart';

@immutable
sealed class FireLocationState {}

final class FireLocationInitial extends FireLocationState {}

final class FireLocationSuccess extends FireLocationState {
  final List<FireLocationOrHistoryModel> fireLocationsModel;

  FireLocationSuccess({required this.fireLocationsModel});
}

final class FireLocationLoading extends FireLocationState {}

final class FireLocationFailure extends FireLocationState {
  final String errorMessage;

  FireLocationFailure({required this.errorMessage});
}


