// ignore_for_file: constant_identifier_names

import 'package:fire_gurad_dashboard/blocs/collection_bloc/collection_bloc.dart';
import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:fire_gurad_dashboard/models/center_model.dart';
import 'package:fire_gurad_dashboard/models/device_model.dart';
import 'package:fire_gurad_dashboard/models/forest_model.dart';
import 'package:fire_gurad_dashboard/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graphic/graphic.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/loading_widget.dart';

enum DeviceStatus {
  Dangerous,
  Potential,
  Safe,
}

Color deviceZoneColor = Colors.black;

class MapAndLocationsPage extends StatelessWidget {
  const MapAndLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => CollectionBloc()
        ..add(
          FetchColllectionSystemForMap(),
        ),
      child: Scaffold(
        body: BlocBuilder<CollectionBloc, CollectionState>(
          builder: (context, state) {
            if (state is CollectionLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is CollectionSuccess) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: FlutterMap(
                      mapController: MapController(),
                      options: const MapOptions(
                        initialCenter: LatLng(
                          34.8021,
                          38.9968,
                        ),
                        initialZoom: 8,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        CircleLayer(
                          circles: [
                            // ! forsts zone
                            ...List.generate(
                              state.collectionSystemModel.forestes!.length,
                              (index) {
                                return CircleMarker(
                                  borderColor: Colors.black,
                                  borderStrokeWidth: 0.5,
                                  color: Colors.black.withOpacity(0.1),
                                  point: LatLng(
                                    double.parse(
                                      state.collectionSystemModel
                                          .forestes![index]!.latitude!,
                                    ),
                                    double.parse(
                                      state.collectionSystemModel
                                          .forestes![index]!.longitude!,
                                    ),
                                  ),
                                  radius: 20000,
                                  useRadiusInMeter: true,
                                );
                              },
                            ),
                            // ! device zone
                            ...List.generate(
                              state.collectionSystemModel.devices!.length,
                              (index) {
                                if (state.collectionSystemModel.devices![index]!
                                        .deviceValues!.status! ==
                                    DeviceStatus.Dangerous.name) {
                                  deviceZoneColor = Colors.red;
                                } else if (state
                                        .collectionSystemModel
                                        .devices![index]!
                                        .deviceValues!
                                        .status! ==
                                    DeviceStatus.Potential.name) {
                                  deviceZoneColor = Colors.orange;
                                } else {
                                  deviceZoneColor = Colors.green;
                                }
                                return CircleMarker(
                                  borderColor: deviceZoneColor,
                                  borderStrokeWidth: 0.5,
                                  color: deviceZoneColor.withOpacity(0.2),
                                  point: LatLng(
                                    double.parse(
                                      state.collectionSystemModel
                                          .devices![index]!.latitude!,
                                    ),
                                    double.parse(
                                      state.collectionSystemModel
                                          .devices![index]!.longitude!,
                                    ),
                                  ),
                                  radius: 2000,
                                  useRadiusInMeter: true,
                                );
                              },
                            ),
                          ],
                        ),
                        MarkerLayer(
                          markers: [
                            // ! devices
                            ...List.generate(
                              state.collectionSystemModel.devices!.length,
                              (index) {
                                DeviceModel device = state
                                    .collectionSystemModel.devices![index]!;
                                return Marker(
                                  point: LatLng(
                                    double.parse(device.latitude!),
                                    double.parse(
                                      device.longitude!,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.speed,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                            // ! centers
                            ...List.generate(
                              state.collectionSystemModel.centers!.length,
                              (index) {
                                CenterModel center = state
                                    .collectionSystemModel.centers![index]!;
                                return Marker(
                                  point: LatLng(
                                    double.parse(center.latitude!),
                                    double.parse(
                                      center.longitude!,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.apartment,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                            // ! forests
                            ...List.generate(
                              state.collectionSystemModel.forestes!.length,
                              (index) {
                                ForestModel forest = state
                                    .collectionSystemModel.forestes![index]!;
                                return Marker(
                                  point: LatLng(
                                    double.parse(forest.latitude!),
                                    double.parse(forest.longitude!),
                                  ),
                                  child: const Icon(
                                    Icons.forest,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                            // ! fires
                          //   ...List.generate(
                          //     state.collectionSystemModel.fires!.length,
                          //     (index) {
                          //       DeviceModel device = state
                          //           .collectionSystemModel.devices![index]!;
                          //       return Marker(
                          //         point: LatLng(
                          //           double.parse(device.latitude!) + 0.3,
                          //           double.parse(
                          //             device.longitude!,
                          //           ),
                          //         ),
                          //         child: const Icon(
                          //           Icons.whatshot,
                          //           color: Colors.red,
                          //           size: 40,
                          //         ),
                          //       );
                          //     },
                          //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Temperature',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          height: screenHeight / 4.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor,
                            ),
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: Chart(
                            data: List.generate(
                              state.collectionSystemModel.devices!.length,
                              (index) {
                                return {
                                  'genre': state.collectionSystemModel
                                      .devices![index]!.name,
                                  'sold': state.collectionSystemModel
                                      .devices![index]!.deviceValues!.valueHeat,
                                };
                              },
                            ),
                            // data: const [
                            //   {'genre': 'Sports', 'sold': 275},
                            //   {'genre': 'Strategy', 'sold': 115},
                            //   {'genre': 'Action', 'sold': 120},
                            //   {'genre': 'Shooter', 'sold': 350},
                            //   {'genre': 'Other', 'sold': 150},
                            // ],
                            variables: {
                              'genre': Variable(
                                accessor: (Map map) => map['genre'] as String,
                              ),
                              'sold': Variable(
                                accessor: (Map map) => map['sold'] as num,
                              ),
                            },
                            marks: [
                              IntervalMark(
                                shape: ShapeEncode(
                                  value: RectShape(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        3,
                                      ),
                                    ),
                                  ),
                                ),
                                color: ColorEncode(
                                  value: Colors.red,
                                ),
                              ),
                            ],
                            axes: [
                              Defaults.horizontalAxis,
                              Defaults.verticalAxis,
                            ],
                          ),
                        ),
                        const Text(
                          'Humidity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          height: screenHeight / 4.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                            ),
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: Chart(
                            data: List.generate(
                              state.collectionSystemModel.devices!.length,
                              (index) {
                                return {
                                  'genre': state.collectionSystemModel
                                      .devices![index]!.name,
                                  'sold': state.collectionSystemModel
                                      .devices![index]!.deviceValues!.valueGas,
                                };
                              },
                            ),
                            // data: const [
                            //   {'genre': 'Sports', 'sold': 275},
                            //   {'genre': 'Strategy', 'sold': 115},
                            //   {'genre': 'Action', 'sold': 120},
                            //   {'genre': 'Shooter', 'sold': 350},
                            //   {'genre': 'Other', 'sold': 150},
                            // ],
                            variables: {
                              'genre': Variable(
                                accessor: (Map map) => map['genre'] as String,
                              ),
                              'sold': Variable(
                                accessor: (Map map) => map['sold'] as num,
                              ),
                            },
                            marks: [
                              IntervalMark(
                                shape: ShapeEncode(
                                  value: RectShape(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        3,
                                      ),
                                    ),
                                  ),
                                ),
                                color: ColorEncode(
                                  value: Colors.green,
                                ),
                              ),
                            ],
                            axes: [
                              Defaults.horizontalAxis,
                              Defaults.verticalAxis,
                            ],
                          ),
                        ),
                        const Text(
                          'Gas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          height: screenHeight / 4.5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: Chart(
                            data: List.generate(
                              state.collectionSystemModel.devices!.length,
                              (index) {
                                return {
                                  'genre': state.collectionSystemModel
                                      .devices![index]!.name,
                                  'sold': state
                                      .collectionSystemModel
                                      .devices![index]!
                                      .deviceValues!
                                      .valueMoisture,
                                };
                              },
                            ),
                            // data: const [
                            //   {'genre': 'Sports', 'sold': 275},
                            //   {'genre': 'Strategy', 'sold': 115},
                            //   {'genre': 'Action', 'sold': 120},
                            //   {'genre': 'Shooter', 'sold': 350},
                            //   {'genre': 'Other', 'sold': 150},
                            // ],
                            variables: {
                              'genre': Variable(
                                accessor: (Map map) => map['genre'] as String,
                              ),
                              'sold': Variable(
                                accessor: (Map map) => map['sold'] as num,
                              ),
                            },
                            marks: [
                              IntervalMark(
                                shape: ShapeEncode(
                                  value: RectShape(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        3,
                                      ),
                                    ),
                                  ),
                                ),
                                color: ColorEncode(
                                  value: Colors.blue,
                                ),
                              ),
                            ],
                            axes: [
                              Defaults.horizontalAxis,
                              Defaults.verticalAxis,
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  12,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Device Marker',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.speed,
                                      color: primaryColor,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Center Marker',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.apartment,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Forest Marker',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.forest,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Fire Marker',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.whatshot,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CollectionError) {
              return ErrorMessageWidget(errorMessage: state.errorMessage);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
