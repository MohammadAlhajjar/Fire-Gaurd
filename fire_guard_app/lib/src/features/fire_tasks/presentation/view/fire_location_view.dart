// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/respository/fire_location_repository.dart';
import 'package:fire_guard_app/src/features/fire_tasks/data/service/fire_location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';

import 'package:fire_guard_app/core/resource/colors_manager.dart';
import 'package:fire_guard_app/core/resource/constants_manager.dart';
import 'package:fire_guard_app/core/resource/images_manager.dart';
import 'package:fire_guard_app/core/resource/styles_manager.dart';
import 'package:fire_guard_app/src/features/fire_tasks/presentation/view/home_view.dart';

import '../../../../../core/network/network_connection_info.dart';
import '../blocs/fire_location_bloc/fire_location_bloc.dart';

class FireLocationView extends StatefulWidget {
  const FireLocationView({
    super.key,
    required this.fireId,
    required this.fireTruckLatLng,
  });
  final int fireId;
  final LatLng fireTruckLatLng;

  @override
  State<FireLocationView> createState() => _FireLocationViewState();
}

class _FireLocationViewState extends State<FireLocationView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => FireLocationBloc(
        fireLocationRepo: FireLocationRepoImpl(
          internetConnectionInfo: InternetConnectionInfo(
            internetConnectionChecker: InternetConnectionChecker(),
          ),
          fireLocationService: FireLocationService(
            dio: Dio(),
          ),
        ),
      )..add(
          GetFireLocation(
            fireId: widget.fireId,
          ),
        ),
      child: Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        body: BlocBuilder<FireLocationBloc, FireLocationState>(
          builder: (context, state) {
            if (state is FireLocationSuccess) {
              return Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight / 1.5,
                    child: Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            initialCenter: widget.fireTruckLatLng,
                            initialZoom: 5.5,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  ConstantsManager.flutterMapUrlTemplate,
                              userAgentPackageName:
                                  ConstantsManager.userAgentPackageName,
                            ),
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: [
                                    widget.fireTruckLatLng,
                                    LatLng(
                                      double.parse(
                                        state.fireLocationModel.forest!.address!
                                            .latitude!,
                                      ),
                                      double.parse(
                                        state.fireLocationModel.forest!.address!
                                            .latitude!,
                                      ),
                                    )
                                  ],
                                  color:
                                      ColorsManager.blackColor.withOpacity(0.7),
                                  strokeWidth: 2,
                                )
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: widget.fireTruckLatLng,
                                  // double.parse(
                                  //   state.fireStationCenterDetails.address!
                                  //       .latitude!,
                                  // ),
                                  // double.parse(
                                  //   state.fireStationCenterDetails.address!
                                  //       .longitude!,
                                  // ),
                                  child: const Icon(
                                    Icons.fire_truck,
                                    color: ColorsManager.primaryColor,
                                    size: 40,
                                  ),
                                ),
                                Marker(
                                  // point: LatLng(35.2, 38.2),
                                  point: LatLng(
                                    double.parse(
                                      state.fireLocationModel.forest!.address!
                                          .latitude!,
                                    ),
                                    double.parse(
                                      state.fireLocationModel.forest!.address!
                                          .latitude!,
                                    ),
                                  ),

                                  child: const Icon(
                                    Icons.local_fire_department,
                                    color: ColorsManager.primaryColor,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: const Alignment(-0.88, -0.8),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: ColorsManager.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    12,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  height: 16,
                                  ImagesManager.arrowBackwardVectorSvg,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const FlameConatiner(),
                            const Gap(17),
                            Text(
                              'Fire Alert',
                              style: StylesManager.interFontFamilyBold(
                                fontSize: 16,
                                color: ColorsManager.blackColor,
                              ),
                            )
                          ],
                        ),
                        const Gap(26.5),
                        const FirePointLocation(
                          pointCarachter: 'A Point:',
                          pointNameLocation: 'Fire Station Location',
                          pointIcon: Icons.fire_truck,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          height: screenHeight / 10,
                          child: const VerticalDivider(
                            thickness: 2,
                            indent: 0.5,
                            endIndent: 0.5,
                            color: ColorsManager.blackColor,
                          ),
                        ),
                        const FirePointLocation(
                          pointIcon: Icons.whatshot,
                          pointCarachter: 'B Point:',
                          pointNameLocation: 'Fire Location',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is FireLocationFailure) {
              return Center(
                child: Text(
                  'Server problem, Please try again later . . .',
                  style: StylesManager.interFontFamilyBold(
                    fontSize: 14,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class FirePointLocation extends StatelessWidget {
  const FirePointLocation({
    super.key,
    required this.pointCarachter,
    required this.pointNameLocation,
    required this.pointIcon,
  });
  final String pointCarachter;
  final String pointNameLocation;
  final IconData pointIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          minRadius: 15,
          backgroundColor: ColorsManager.primaryColor,
          child: Icon(
            pointIcon,
            color: ColorsManager.whiteColor,
          ),
        ),
        const Gap(10),
        Text(pointCarachter),
        const Spacer(),
        Text(pointNameLocation)
      ],
    );
  }
}
