import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/device_bloc/device_bloc.dart';
import '../models/device_model.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceBloc()
        ..add(
          FetchDeviceData(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Devices',
          ),
        ),
        body: BlocBuilder<DeviceBloc, DeviceState>(
          builder: (context, state) {
            if (state is DeviceLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            } else if (state is DeviceSuccess) {
              return PlutoGrid(
                columns: _buildColumns(),
                rows: _buildRow(state.devices),
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
            } else if (state is DeviceError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              return const Center(child: Text('No data available'));
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
      title: 'Description',
      field: 'Description',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Latitude',
      field: 'Latitude',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Longitude',
      field: 'Longitude',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Forest ID',
      field: 'Forest ID',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Created At',
      field: 'Created At',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Updated At',
      field: 'Updated At',
      type: PlutoColumnType.text(),
    ),
  ];
}

List<PlutoRow> _buildRow(List<DeviceModel> devices) {
  return devices.map((device) {
    return PlutoRow(cells: {
      'ID': PlutoCell(value: device.id),
      'Name': PlutoCell(value: device.name),
      'Description': PlutoCell(value: device.description),
      'Latitude': PlutoCell(value: device.address!.latitude),
      'Longitude': PlutoCell(value: device.address!.longitude),
      'Forest ID': PlutoCell(value: device.forest!.id),
      'Created At': PlutoCell(value: device.createdAt),
      'Updated At': PlutoCell(value: device.updatedAt),
    });
  }).toList();
}
