import 'package:fire_gurad_dashboard/blocs/forest_bloc/forest_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:fire_gurad_dashboard/models/forest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ForestsPage extends StatelessWidget {
  const ForestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForestBloc()..add(FetchForests()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forests',
          ),
        ),
        body: BlocBuilder<ForestBloc, ForestState>(
          builder: (context, state) {
            if (state is ForestLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is ForestSuccess) {
              return PlutoGrid(
                mode: PlutoGridMode.readOnly,
                columns: _buildColumns(),
                rows: _buildRows(state.forests),
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
            } else if (state is ForestError) {
              return Center(
                child: Text(
                  'Error: ${state.errorMessage}',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }
            return Container();
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
        title: 'Details',
        field: 'Details',
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text('Details'),
          );
        },
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<ForestModel> forests) {
    return forests.map((forest) {
      return PlutoRow(
        cells: {
          'ID': PlutoCell(value: forest.id),
          'Name': PlutoCell(value: forest.name),
          'Description': PlutoCell(value: forest.description),
          'Created At': PlutoCell(value: forest.createdAt),
          'Details': PlutoCell(value: forest.id),
        },
      );
    }).toList();
  }

