import 'package:fire_gurad_dashboard/blocs/center_bloc/center_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../models/center_model.dart';

class CentersPage extends StatelessWidget {
  const CentersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CenterBloc()
        ..add(
          FetchCenters(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Centers'),
        ),
        body: BlocBuilder<CenterBloc, CenterState>(
          builder: (context, state) {
            if (state is CenterLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is CenterSuccess) {
              return PlutoGrid(
                columns: _buildColumns(),
                rows: _buildRows(state.centers),
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
            } else if (state is CenterError) {
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
}

List<PlutoColumn> _buildColumns() {
  return [
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'ID',
      field: 'ID',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Name',
      field: 'Name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Description',
        field: 'Description',
        type: PlutoColumnType.text()),
    PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Phone Number',
        field: 'Phone Number',
        type: PlutoColumnType.text()),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Status',
      field: 'Status',
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
  ];
}

List<PlutoRow> _buildRows(List<CenterModel> centers) {
  return centers.map((center) {
    return PlutoRow(cells: {
      'ID': PlutoCell(value: center.id),
      'Name': PlutoCell(value: center.name),
      'Description': PlutoCell(value: center.description),
      'Phone Number': PlutoCell(value: center.phoneNumber),
      'Status': PlutoCell(value: center.status),
      'Created At': PlutoCell(value: center.createdAt),
    });
  }).toList();
}
