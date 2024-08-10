import 'package:fire_gurad_dashboard/blocs/fires_bloc/fires_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:fire_gurad_dashboard/models/fire_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

class FireGridPage extends StatelessWidget {
  const FireGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FiresBloc()
        ..add(
          FetchFiresEvent(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fires Table'),
        ),
        body: BlocBuilder<FiresBloc, FiresState>(
          builder: (context, state) {
            if (state is FiresLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is FiresSuccess) {
              return PlutoGrid(
                mode: PlutoGridMode.readOnly,
                columns: _buildColumns(),
                rows: _buildRows(state.fires),
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
            } else if (state is FiresError) {
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
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Forest',
        field: 'Forest',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Last Updated',
        field: 'Last Updated',
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

  List<PlutoRow> _buildRows(List<FireModel> fires) {
    return fires.map((fire) {
      return PlutoRow(
        cells: {
          'ID': PlutoCell(value: fire.id),
          'Status': PlutoCell(value: fire.status!.label),
          'Forest': PlutoCell(value: fire.forest!.name),
          'Last Updated': PlutoCell(value: fire.updatedAt),
          'Details': PlutoCell(value: fire.device!.id),
        },
      );
    }).toList();
  }
}
