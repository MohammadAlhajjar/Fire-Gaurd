part of 'fire_location_bloc.dart';

@immutable
sealed class FireLocationEvent {}

final class GetFireLocation extends FireLocationEvent{
  final int fireId;

  GetFireLocation({required this.fireId});
}
