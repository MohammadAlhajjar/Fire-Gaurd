import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../models/fire_brigade_model.dart';

part 'fire_brigade_event.dart';
part 'fire_brigade_state.dart';

class FireBrigadeBloc extends Bloc<FireBrigadeEvent, FireBrigadeState> {
  FireBrigadeBloc() : super(FireBrigadeInitial()) {
    on<FetchFireBrigades>((event, emit) async {
      emit(FireBrigadeLoading());
      try {
        final response = await http.get(
            Uri.parse(
                'https:firegard.cupcoding.com/backend/public/api/admin/fire-brigades'),
            headers: {
              'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
            });

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<FireBrigadeModel> fireBrigades = List.generate(
            data['pagination']['items'].length,
            (index) => FireBrigadeModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(FireBrigadeSuccess(fireBrigades: fireBrigades));
        } else {
          emit(
            FireBrigadeError(
              errorMessage: 'Failed to load fire brigades',
            ),
          );
        }
      } catch (e) {
        emit(
          FireBrigadeError(
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
