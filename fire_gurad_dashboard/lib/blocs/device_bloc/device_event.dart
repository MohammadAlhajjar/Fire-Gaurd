part of 'device_bloc.dart';

@immutable
sealed class DeviceEvent {}

class FetchDeviceData extends DeviceEvent {}
