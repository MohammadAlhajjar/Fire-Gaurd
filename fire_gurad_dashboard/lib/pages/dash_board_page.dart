import 'package:fire_gurad_dashboard/core/colors.dart';
import 'package:fire_gurad_dashboard/pages/centers_page.dart';
import 'package:fire_gurad_dashboard/pages/devices_page.dart';
import 'package:fire_gurad_dashboard/pages/fire_brigades_page.dart';
import 'package:fire_gurad_dashboard/pages/fires_page.dart';
import 'package:fire_gurad_dashboard/pages/forest_page.dart';
import 'package:fire_gurad_dashboard/pages/map_and_locations.dart';
import 'package:fire_gurad_dashboard/pages/task_fire_brigades_page.dart';
import 'package:flutter/material.dart';

import 'cars_page.dart';
import 'device_value_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> pages = [
    {
      'title': 'Map',
      'page': const MapAndLocationsPage(),
    },
    {
      'title': 'Fires',
      'page': const FireGridPage(),
    },
    {
      'title': 'Task Fire Brigades',
      'page': const TaskFireBrigadePage(),
    },
    {
      'title': 'Device Values',
      'page': const DeviceValuesPage(),
    },
    {
      'title': 'Devices',
      'page': const DevicesPage(),
    },
    {
      'title': 'Forests',
      'page': const ForestsPage(),
    },
    {
      'title': 'Centers',
      'page': const CentersPage(),
    },
    {
      'title': 'Cars',
      'page': const CarsPage(),
    },
    {
      'title': 'Fire Brigades',
      'page': const FireBrigadesPage(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            width: 250,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.zero,
              ),
            ),
            backgroundColor: const Color(0xff333333),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 30,
                  ),
                  child: Image.asset(
                    fit: BoxFit.fill,
                    'assets/images/logo.png',
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        selected: selectedIndex == index ? true : false,
                        selectedTileColor: primaryColor,
                        selectedColor: Colors.white,
                        textColor: Colors.white,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        title: Text(
                          pages[index]['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                                selectedIndex == index ? FontWeight.w900 : null,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: pages[selectedIndex]['page'],
          ),
        ],
      ),
    );
  }
}
