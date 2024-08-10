import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:fire_gurad_dashboard/models/car_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc() : super(CarInitial()) {
    on<FetchCars>((event, emit) async {
      emit(CarLoading());
      try {
        final response = await http.get(
            Uri.parse(
                'https://firegard.cupcoding.com/backend/public/api/admin/cars'),
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<CarModel> cars = List.generate(
            data['pagination']['items'].length,
            (index) => CarModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(CarSuccess(cars: cars));
        } else {
          emit(
            CarError(
              errorMessage: 'Failed to load cars',
            ),
          );
        }
      } catch (e) {
        emit(
          CarError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
