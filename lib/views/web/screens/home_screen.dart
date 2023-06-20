import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../utils/colors.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pickupController = TextEditingController();
  final dropoffController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: primary,
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBold(
                    text: 'Pack & Go',
                    fontSize: 38,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, Routes.signuppage);
                    },
                    child: TextRegular(
                      text: 'Records',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          const Expanded(child: SizedBox()),
          const Divider(),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWidget(
                      textColor: Colors.black,
                      radius: 5,
                      color: Colors.white,
                      height: 45,
                      width: 150,
                      label: 'Back',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonWidget(
                      radius: 5,
                      color: primary,
                      height: 45,
                      width: 150,
                      label: 'Continue',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
