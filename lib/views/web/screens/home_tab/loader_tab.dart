import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/views/web/screens/home_screen.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';

class LoaderTab extends StatefulWidget {
  const LoaderTab({super.key});

  @override
  State<LoaderTab> createState() => _LoaderTabState();
}

class _LoaderTabState extends State<LoaderTab> {
  List<Map<String, String>> vehicles = [
    {"name": "Motorcycle", "image": "motorcycle.png"},
    {"name": "500 Kg Jeepney (Standard Type)", "image": "500-kg-Jeepney-(Standard-Type).png"},
    {"name": "800 Kg Jeepney (Lawin Type)", "image": "800-kg-Jeepney-(Lawin-Type).png"},
    {"name": "300 Kg Taxi Sedan", "image": "300-Kg-Taxi.png"},
    {"name": "500 Kg Taxi MPV", "image": "500-Kg-Tax- MPV.png"},
    {"name": "6-Wheel Truck Close Type", "image": "6-Wheel-Truck-Close-Type.png"},
    {"name": "10-Wheel Truck Close Type", "image": "10-Wheel-Truck-Close-Type.png"},
    {"name": "6-Wheel Truck Open Type", "image": "6-Wheel-Truck-Open-Type.png"},
    {"name": "10-Wheel Truck Open Type", "image": "10-Wheel-Truck-Open-Type.png"},
  ];

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextBold(
          text: 'Would you like to add a loader & unloader?',
          fontSize: 22,
          color: Colors.black,
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          textColor: Colors.black,
          color: Colors.white,
          width: 500,
          radius: 5,
          label: 'Yes',
          onPressed: () {
            addLoaderAndUnloader = true;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          color: Colors.white,
          textColor: Colors.red,
          width: 500,
          radius: 5,
          label: 'No',
          onPressed: () {
            addLoaderAndUnloader = false;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        TextBold(
          text: 'Would you like to add a rearranger?',
          fontSize: 22,
          color: Colors.black,
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          textColor: Colors.black,
          color: Colors.white,
          width: 500,
          radius: 5,
          label: 'Yes',
          onPressed: () {
            addRearranger = true;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          color: Colors.white,
          textColor: Colors.red,
          width: 500,
          radius: 5,
          label: 'No',
          onPressed: () {
            addRearranger = false;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(),
        const SizedBox(
          height: 20,
        ),
        TextBold(
          text: 'What type of vehicle do you prefer?',
          fontSize: 22,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 230,
          width: 500,
          child: Scrollbar(
            controller: scrollController,
            child: ListView.builder(
                controller: scrollController,
                itemCount: vehicles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      height: 190,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                            child: Image.asset(
                              'assets/images/${vehicles[index]['image']}',
                              height: 150,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          TextBold(
                            text: vehicles[index]['name']!,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    ));
  }
}
