// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/services/add_order.dart';
import 'package:packandgo/widgets/toast_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../queries/authQuery.dart';
import '../../../../queries/queries.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/text_widget.dart';

import 'auth/login_screen.dart';
import 'home_tab/details_tab.dart';
import 'home_tab/loader_tab.dart';
import 'home_tab/location_tab.dart';
import 'home_tab/map_tab.dart';

List<Map<String, String>> vehicles = [
  {"name": "Motorcycle", "image": "motorcycle.png"},
  {
    "name": "500 Kg Jeepney (Standard Type)",
    "image": "500-kg-Jeepney-(Standard-Type).png"
  },
  {
    "name": "800 Kg Jeepney (Lawin Type)",
    "image": "800-kg-Jeepney-(Lawin-Type).png"
  },
  {"name": "300 Kg Taxi Sedan", "image": "300-Kg-Taxi.png"},
  {"name": "500 Kg Taxi MPV", "image": "500-Kg-Taxi-MPV.png"},
  {"name": "6-Wheel Truck Close Type", "image": "6-Wheel-Truck-Close-Type.png"},
  {
    "name": "10-Wheel Truck Close Type",
    "image": "10-Wheel-Truck-Close-Type.png"
  },
  {"name": "6-Wheel Truck Open Type", "image": "6-Wheel-Truck-Open-Type.png"},
  {"name": "10-Wheel Truck Open Type", "image": "10-Wheel-Truck-Open-Type.png"},
];

final pickupController = TextEditingController();
final dropoffController = TextEditingController();
// final pickupUnitController = TextEditingController();
// final dropoffUnitController = TextEditingController();
final pickupAdditionalController = TextEditingController();
final dropoffAdditionalController = TextEditingController();
final newContactnumberController = TextEditingController();
final newAlernativcontactnumberController = TextEditingController();
final newEmailController = TextEditingController();
String vehicle = 'Motorcycle';

bool check1 = true;
bool check2 = false;
bool check3 = false;

bool addLoaderAndUnloader = false;
bool addRearranger = false;
bool isLoading = false;

int selectedIndex = -1;

var userDetails;

final FirebaseAuth _auth = FirebaseAuth.instance;

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
      lastDate: DateTime(2100),
    );
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: !isLoading
          ? SingleChildScrollView(
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
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.recordspage);
                                },
                                child: TextRegular(
                                  text: 'Records',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              PopupMenuButton(
                                iconSize: 150,
                                icon: TextRegular(
                                  text: "User",
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.profilepag);
                                        Navigator.pushNamed(
                                            context, Routes.profilepag);
                                      },
                                      child: TextRegular(
                                        text: 'My Account',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                    'Logout Confirmation',
                                                    style: TextStyle(
                                                        fontFamily: 'QBold',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: const Text(
                                                    'Are you sure you want to Logout?',
                                                    style: TextStyle(
                                                        fontFamily: 'QRegular'),
                                                  ),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: const Text(
                                                        'Close',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginScreen(),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                    'Logout Confirmation',
                                                    style: TextStyle(
                                                        fontFamily: 'QBold',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: const Text(
                                                    'Are you sure you want to Logout?',
                                                    style: TextStyle(
                                                        fontFamily: 'QRegular'),
                                                  ),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: const Text(
                                                        'Close',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        final SharedPreferences
                                                            userData =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        var usthQuery =
                                                            AuthQuery();
                                                        await usthQuery
                                                            .signOut();
                                                        await userData.clear();
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LoginScreen()));
                                                      },
                                                      child: const Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'QRegular',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ));
                                      },
                                      child: TextRegular(
                                        text: 'Logout',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 500,
                    child: IndexedStack(
                      index: currentIndex,
                      children: [
                        MapTab(),
                        LocationTab(),
                        LoaderTab(),
                        DetailsTab(),
                      ],
                    ),
                  ),
                  SizedBox(),
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
                              onPressed: () async {
                                switch (currentIndex) {
                                  case 0:
                                    setState(() => currentIndex++);
                                    break;
                                  case 1:
                                    _selectDateTime(context);
                                    setState(() => currentIndex++);
                                    break;
                                  case 2:
                                    setState(() => currentIndex++);
                                    break;
                                  case 3:
                                    addOrder(
                                        0,
                                        0,
                                        pickupController.text,
                                        dropoffController.text,
                                        pickupAdditionalController.text,
                                        dropoffAdditionalController.text,
                                        selectedDateTime,
                                        addLoaderAndUnloader,
                                        addRearranger,
                                        vehicle);
                                    showToast('Request added succesfully!');

                                    setState(() {
                                      currentIndex = 0;
                                    });
                                    break;
                                  default:
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: CircularProgressIndicator(),
              )),
    );
  }

  saveBookingDetails({required bookingDetails, required initialConvo}) async {
    var query = Queries();
    await query.push("records", bookingDetails);
    await query.push("messages", initialConvo);
  }

  bookingRequestDIalog() {
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
                Navigator.pushNamed(context, Routes.homepage);
                clearControllers();
              },
              child: TextRegular(
                text: 'Close',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }

  clearControllers() {
    pickupController.clear();
    dropoffController.clear();
    pickupAdditionalController.clear();
    dropoffAdditionalController.clear();
    newContactnumberController.clear();
    newAlernativcontactnumberController.clear();
    newEmailController.clear();
  }
}
