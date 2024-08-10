import 'package:fire_gurad_dashboard/blocs/task_fire_brigades_bloc/task_fire_brigades_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:fire_gurad_dashboard/models/task_fire_brigade_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

class TaskFireBrigadePage extends StatelessWidget {
  const TaskFireBrigadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskFireBrigadesBloc()
        ..add(
          FetchTaskFireBrigades(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fires Table'),
        ),
        body: BlocBuilder<TaskFireBrigadesBloc, TaskFireBrigadesState>(
          builder: (context, state) {
            if (state is TaskFireBrigadesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is TaskFireBrigadesSuccess) {
              return PlutoGrid(
                mode: PlutoGridMode.readOnly,
                columns: _buildColumns(),
                rows: _buildRows(state.tasks),
                configuration: const PlutoGridConfiguration(
                  columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.equal,
                  ),
                  style: PlutoGridStyleConfig(
                    gridBackgroundColor: Colors.white,
                    activatedColor: Colors.white,
                    activatedBorderColor: Colors.grey,
                    gridBorderRadius: BorderRadius.zero,
                  ),
                ),
              );
            } else if (state is TaskFireBrigadesError) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Unknown state',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

List<PlutoColumn> _buildColumns() {
  return [
    PlutoColumn(
      suppressedAutoSize: true,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'ID',
      field: 'ID',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Fire Brigade',
      field: 'Fire Brigade',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Note',
      field: 'Note',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Created At',
      field: 'Created At',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Fire',
      field: 'Fire',
      type: PlutoColumnType.number(),
      renderer: (rendererContext) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          child: const Text('Fire Details'),
        );
      },
    ),
  ];
}

List<PlutoRow> _buildRows(List<TaskFireBrigadeModel> taskFireBrigades) {
  return taskFireBrigades.map((taskFireBrigade) {
    return PlutoRow(
      cells: {
        'ID': PlutoCell(value: taskFireBrigade.id),
        'Fire Brigade': PlutoCell(value: taskFireBrigade.fireBrigade!.name),
        'Note': PlutoCell(value: taskFireBrigade.note!),
        'Created At': PlutoCell(value: taskFireBrigade.createdAt),
        'Fire': PlutoCell(value: taskFireBrigade.fire!.id),
      },
    );
  }).toList();
}
