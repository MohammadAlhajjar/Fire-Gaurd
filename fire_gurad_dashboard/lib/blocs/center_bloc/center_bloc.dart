import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:fire_gurad_dashboard/models/center_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'center_event.dart';
part 'center_state.dart';

class CenterBloc extends Bloc<CenterEvent, CenterState> {
  CenterBloc() : super(CenterInitial()) {
    on<CenterEvent>((event, emit) async {
      emit(CenterLoading());
      try {
        final response = await http.get(
            Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/centers',
            ),
            headers: {
              'Authorization':
                  'Bearer ${sharedPreferences.getString('token')}', // Replace with your token
            });

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          final List<CenterModel> centers = List.generate(
            data['pagination']['items'].length,
            (index) => CenterModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(
            CenterSuccess(centers: centers),
          );
        } else {
          emit(
            CenterError(
              errorMessage: 'Failed to load centers',
            ),
          );
        }
      } catch (e) {
        emit(CenterError(errorMessage: e.toString()));
      }
    });
  }
}
