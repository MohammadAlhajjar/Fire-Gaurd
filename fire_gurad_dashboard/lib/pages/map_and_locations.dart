import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapAndLocationsPage extends StatelessWidget {
  const MapAndLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
        ],
      ),
    );
  }
}
