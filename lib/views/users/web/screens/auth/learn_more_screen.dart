// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/widgets/text_widget.dart';

import '../../../../../queries/authQuery.dart';
import '../../../../../queries/queries.dart';
import '../../../../../utils/routes.dart';

class LearnMore extends StatefulWidget {
  const LearnMore({super.key});
  @override
  State<LearnMore> createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var auth = AuthQuery();
  var userDetailsQuery = Queries();

  bool isLoading = false;
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> params =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ??
            {"learn-type": "vehicle"};

    return Scaffold(
      body: !isLoading
          ? SingleChildScrollView(
              child: Column(
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
                            Navigator.pushNamed(context, Routes.signuppage);
                          },
                          child: TextRegular(
                            text: 'Signup',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                if (params["learn-type"] == "vehicle")
                  Container(
                    width: 500,
                    height: 1000,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        textWidget(
                            text: "CHOOSE A VEHICLE", caps: true, isBold: true),
                        textWidget(
                            text: "Learn More about Our Vehicle Options:"),
                        textWidget(
                            text:
                                "Motorcycle: Perfect for quick and agile transportation needs.",
                            isBullet: true),
                        textWidget(
                            text:
                                "500 kg Jeepney (Standard Type): Ideal for comfortable and spacious rides for a group of passengers.",
                            isBullet: true),
                        textWidget(
                            text:
                                "800 kg Jeepney (Lawin Type): Designed to handle heavier loads while providing a smooth and reliable journey.",
                            isBullet: true),
                        textWidget(
                            text:
                                "300 kg Taxi Sedan: A compact and efficient choice for individual or small group transportation.",
                            isBullet: true),
                        textWidget(
                            text:
                                "500 kg Taxi MPV: A larger taxi option with more seating capacity for a comfortable ride.",
                            isBullet: true),
                        textWidget(
                            text:
                                "6-Wheel Truck (Close Type): Suitable for medium-sized cargo transportation with added security.",
                            isBullet: true),
                        textWidget(
                            text:
                                "10-Wheel Truck (Close Type): Provides ample space and security for larger cargo shipments.",
                            isBullet: true),
                        textWidget(
                            text:
                                "6-Wheel Truck (Open Type): Ideal for transporting bulk materials or goods that do not require closed storage.",
                            isBullet: true),
                        textWidget(
                            text:
                                "10-Wheel Truck (Open Type): Designed for heavy-duty hauling of larger loads.",
                            isBullet: true),
                        textWidget(
                            text:
                                "Choose the perfect vehicle for your specific transportation needs."),
                      ],
                    ),
                  ),
                if (params["learn-type"] == "loader")
                  Container(
                    width: 500,
                    height: 1000,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        textWidget(
                            text: "CHOOSE A LOADER", caps: true, isBold: true),
                        textWidget(
                            text: "Learn More about Our Helper Services:"),
                        textWidget(
                          text:
                              "Motorcycle: Perfect for quick and agile transportation needs.",
                        ),
                        textWidget(
                          text:
                              "Professional Loaders: Our experienced loaders will efficiently handle the loading and unloading of your belongings, ensuring their safety during the move.",
                        ),
                        textWidget(
                          text:
                              "Packing and Unpacking Assistance: Our helpers can assist you with packing your items securely and unpacking them at your new location, saving you time and effort.",
                        ),
                        textWidget(
                          text:
                              "Furniture Assembly and Disassembly: If you have large furniture pieces that require assembly or disassembly, our helpers can take care of it for you, ensuring proper handling and reassembly.",
                        ),
                        textWidget(
                          text:
                              "Heavy Lifting: For bulky and heavy items that require extra strength, our helpers are equipped to handle the lifting and moving with utmost care.",
                        ),
                        textWidget(
                          text:
                              "Customized Help: We understand that every move is unique, so our helpers can adapt to your specific needs and provide personalized assistance.",
                        ),
                      ],
                    ),
                  ),
              ],
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
