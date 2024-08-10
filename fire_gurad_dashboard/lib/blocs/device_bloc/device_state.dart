part of 'device_bloc.dart';

@immutable
sealed class DeviceState {}

final class DeviceInitial extends DeviceState {}

class DeviceLoading extends DeviceState {}

class DeviceSuccess extends DeviceState {
  final List<DeviceModel> devices;

  DeviceSuccess({required this.devices});
}

class DeviceError extends DeviceState {
  final String errorMessage;

  DeviceError({required this.errorMessage});
}
