import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:fire_gurad_dashboard/models/forest_model.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'forest_event.dart';
part 'forest_state.dart';

class ForestBloc extends Bloc<ForestEvent, ForestState> {
  ForestBloc() : super(ForestInitial()) {
    on<FetchForests>((event, emit) async {
      emit(ForestLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/forests'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<ForestModel> forests = List.generate(
            data['pagination']['items'].length,
            (index) => ForestModel.fromMap(
              data['pagination']['items'][index],
            ),
          );
          emit(ForestSuccess(forests: forests));
        } else {
          emit(ForestError(errorMessage: 'Failed to fetch data'));
        }
      } catch (error) {
        emit(ForestError(errorMessage: error.toString()));
      }
    });
  }
}
