import 'package:flutter/material.dart';
import 'package:packandgo/views/web/screens/home_tab/details_tab.dart';
import 'package:packandgo/views/web/screens/home_tab/loader_tab.dart';
import 'package:packandgo/views/web/screens/home_tab/location_tab.dart';
import 'package:packandgo/views/web/screens/home_tab/map_tab.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  DateTime selectedDateTime = DateTime.now();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          selectedDateTime.hour,
          selectedDateTime.minute,
        );
      });
    }

    final TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timePicked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          timePicked.hour,
          timePicked.minute,
        );
        currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: 1000,
        child: Column(
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
            IndexedStack(
              index: currentIndex,
              children: [
                MapTab(),
                const LocationTab(),
                const LoaderTab(),
                DetailsTab(),
              ],
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
                      currentIndex != 0
                          ? ButtonWidget(
                              textColor: Colors.black,
                              radius: 5,
                              color: Colors.white,
                              height: 45,
                              width: 150,
                              fontSize: 14,
                              label: 'Back',
                              onPressed: () {
                                setState(() {
                                  currentIndex--;
                                });
                              },
                            )
                          : const SizedBox(),
                      const SizedBox(
                        width: 20,
                      ),
                      ButtonWidget(
                          radius: 5,
                          color: primary,
                          height: 45,
                          width: 150,
                          fontSize: 14,
                          label: currentIndex != 3
                              ? 'Continue'
                              : 'Request Booking',
                          onPressed: () {
                            if (currentIndex == 1) {
                              _selectDateTime(context);
                            } else if (currentIndex == 3) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: TextRegular(
                                        text: 'Booking Request Received',
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      content: SizedBox(
                                        width: 300,
                                        height: 150,
                                        child: Center(
                                          child: TextRegular(
                                            text:
                                                'Thankyou for your booking request\n\nOur of our drivers will communicate with you in the chatbox to discuss the best price for your move service. Your booking status is currently set to pending until both parties agree on the cost.\n\nWe appreciate your business!',
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, Routes.homepage);
                                          },
                                          child: TextRegular(
                                            text: 'Close',
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              setState(() {
                                currentIndex++;
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
