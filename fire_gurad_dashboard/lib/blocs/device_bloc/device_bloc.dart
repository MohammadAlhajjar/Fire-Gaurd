import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:fire_gurad_dashboard/models/device_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  DeviceBloc() : super(DeviceInitial()) {
    on<FetchDeviceData>((event, emit) async {
      emit(DeviceLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/devices'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<DeviceModel> devices = List.generate(
            data['pagination']['items'].length,
            (index) => DeviceModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(DeviceSuccess(devices: devices));
        } else {
          emit(DeviceError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(DeviceError(errorMessage: error.toString()));
      }
    });
  }
}
