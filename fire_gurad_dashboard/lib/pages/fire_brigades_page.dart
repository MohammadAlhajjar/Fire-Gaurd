import 'package:fire_gurad_dashboard/blocs/fire_brigade_bloc/fire_brigade_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../models/fire_brigade_model.dart';

class FireBrigadesPage extends StatelessWidget {
  const FireBrigadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FireBrigadeBloc()
        ..add(
          FetchFireBrigades(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fire Brigades'),
        ),
        body: BlocBuilder<FireBrigadeBloc, FireBrigadeState>(
          builder: (context, state) {
            if (state is FireBrigadeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is FireBrigadeSuccess) {
              return PlutoGrid(
                columns: _buildColumns(),
                rows: _buildRows(state.fireBrigades),
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
                onChanged: (PlutoGridOnChangedEvent event) {
                  // Handle cell changes
                },
              );
            } else if (state is FireBrigadeError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const Center(
                child: Text(
                  'No data available.',
                ),
              );
            }
          },
        ),
      ),
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'ID',
        field: 'ID',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Name',
        field: 'Name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Email',
        field: 'Email',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Number of Team',
        field: 'Number of Team',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Center',
        field: 'Center',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<FireBrigadeModel> fireBrigades) {
    return fireBrigades.map((brigade) {
      return PlutoRow(cells: {
        'ID': PlutoCell(value: brigade.id),
        'Name': PlutoCell(value: brigade.name),
        'Email': PlutoCell(value: brigade.email),
        'Number of Team': PlutoCell(value: brigade.numberOfTeam),
        'Center': PlutoCell(value: brigade.center!.name),
      });
    }).toList();
  }
}
