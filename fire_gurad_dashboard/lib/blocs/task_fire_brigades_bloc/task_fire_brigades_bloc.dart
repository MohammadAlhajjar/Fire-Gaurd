import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fire_gurad_dashboard/main.dart';
import 'package:fire_gurad_dashboard/models/task_fire_brigade_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'task_fire_brigades_event.dart';
part 'task_fire_brigades_state.dart';

class TaskFireBrigadesBloc
    extends Bloc<TaskFireBrigadesEvent, TaskFireBrigadesState> {
  TaskFireBrigadesBloc() : super(TaskFireBrigadesInitial()) {
    on<FetchTaskFireBrigades>((event, emit) async {
      emit(TaskFireBrigadesLoading());

      try {
        final response = await http.get(
          Uri.parse(
              'https://firegard.cupcoding.com/backend/public/api/admin/task-fire-brigades'),
          headers: {
            'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<TaskFireBrigadeModel> tasks = List.generate(
            data['pagination']['items'].length,
            (index) => TaskFireBrigadeModel.fromMap(
                data['pagination']['items'][index]),
          );
          emit(
            TaskFireBrigadesSuccess(
              tasks: tasks,
            ),
          );
        } else {
          emit(
            TaskFireBrigadesError(
              errorMessage: 'Invalid data format',
            ),
          );
        }
      } catch (e) {
        emit(
          TaskFireBrigadesError(
            errorMessage: 'Error fetching data',
          ),
        );
      }
    });
  }
}
