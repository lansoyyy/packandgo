import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../widgets/text_widget.dart';
import 'package:latlong2/latlong.dart';

class MapTab extends StatelessWidget {
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  int currentIndex = 0;

  MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          TextBold(
            text: 'Where to?',
            fontSize: 24,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.black,
            height: 300,
            width: 500,
            child: FlutterMap(
              options: MapOptions(
                onTap: (tapPosition, point) {
                  // getApiData(point.latitude, point.longitude);
                },
                center: LatLng(8.4803, 124.6498),
                zoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded),
                hintText: 'Pick-Up Location',
                border: InputBorder.none,
              ),
              controller: pickupController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded),
                hintText: 'Drop-Off Location',
                border: InputBorder.none,
              ),
              controller: dropoffController,
            ),
          ),
        ],
      ),
    );
  }
}