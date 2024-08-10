import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/car_bloc/car_bloc.dart';
import '../models/car_model.dart';

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarBloc()..add(FetchCars()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cars'),
        ),
        body: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is CarSuccess) {
              return PlutoGrid(
                columns: _buildColumns(),
                rows: _buildRows(state.cars),
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
            } else if (state is CarError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }

  List<PlutoColumn> _buildColumns() {
    return [
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'ID',
        field: 'ID',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'Name',
        field: 'Name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'Model',
        field: 'Model',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'Number Plate',
        field: 'Number Plate',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'Center',
        field: 'Center',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
        title: 'Created At',
        field: 'Created At',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<CarModel> cars) {
    return cars.map((car) {
      return PlutoRow(cells: {
        'ID': PlutoCell(value: car.id),
        'Name': PlutoCell(value: car.name),
        'Model': PlutoCell(value: car.model),
        'Number Plate': PlutoCell(value: car.numberPlate),
        'Center': PlutoCell(value: car.center!.name),
        'Created At': PlutoCell(value: car.createdAt),
      });
    }).toList();
  }
}
