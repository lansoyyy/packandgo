import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packandgo/queries/authQuery.dart';
import 'package:packandgo/services/add_vehicle.dart';
import 'package:packandgo/views/drivers/auth/login_screen.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/text_widget.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool profiletab = true;
  bool changepasswordtab = false;
  bool vehiclestab = false;
  bool substab = false;
  bool isLoading = false;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  bool passwordVerified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Drivers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              dynamic userDetails = snapshot.data;
              return SingleChildScrollView(
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
                            GestureDetector(
                              onTap: () {},
                              child: TextBold(
                                text: 'Pack & Go',
                                fontSize: 38,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.driverhomescreen);
                                  },
                                  child: TextRegular(
                                    text: 'HOME',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                PopupMenuButton(
                                  iconSize: 150,
                                  icon: TextRegular(
                                    text: 'PROFILE',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        onTap: () {},
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
                                                          fontFamily:
                                                              'QRegular'),
                                                    ),
                                                    actions: <Widget>[
                                                      MaterialButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
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
                                                                      builder:
                                                                          (context) =>
                                                                              const DriverLoginScreen()));
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
                                                          fontFamily:
                                                              'QRegular'),
                                                    ),
                                                    actions: <Widget>[
                                                      MaterialButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
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
                                                                      builder:
                                                                          (context) =>
                                                                              const DriverLoginScreen()));
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
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/profile.png',
                                    height: 75,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextBold(
                                        text:
                                            '${userDetails['fname']} ${userDetails['lname']}',
                                        fontSize: 24,
                                        color: Colors.black,
                                      ),
                                      TextRegular(
                                          text: 'Edit Profile',
                                          fontSize: 16,
                                          color: Colors.grey),
                                      TextRegular(
                                          text: 'Change picture',
                                          fontSize: 16,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(width: 100, child: Divider()),
                              const SizedBox(
                                height: 10,
                              ),
                              TextBold(
                                text: 'My Account',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    profiletab = true;
                                    changepasswordtab = false;
                                    vehiclestab = false;
                                    substab = false;
                                  });
                                },
                                child: TextRegular(
                                    text: 'Profile',
                                    fontSize: 12,
                                    color: profiletab
                                        ? Colors.amber
                                        : Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    profiletab = false;
                                    changepasswordtab = true;
                                    vehiclestab = false;
                                    substab = false;
                                  });
                                },
                                child: TextRegular(
                                    text: 'Change Password',
                                    fontSize: 12,
                                    color: changepasswordtab
                                        ? Colors.amber
                                        : Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    profiletab = false;
                                    changepasswordtab = false;
                                    vehiclestab = true;
                                    substab = false;
                                  });
                                },
                                child: TextRegular(
                                    text: 'Vehicles',
                                    fontSize: 12,
                                    color: vehiclestab
                                        ? Colors.amber
                                        : Colors.grey),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    profiletab = false;
                                    changepasswordtab = false;
                                    vehiclestab = false;
                                    substab = true;
                                  });
                                },
                                child: TextRegular(
                                    text: 'Subscription',
                                    fontSize: 12,
                                    color:
                                        substab ? Colors.amber : Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const SizedBox(height: 500, child: VerticalDivider()),
                          const SizedBox(
                            width: 10,
                          ),
                          profiletab
                              ? profileTab(userDetails)
                              : vehiclestab
                                  ? vehicles()
                                  : substab
                                      ? subscriptiontab(
                                          userDetails['plan'], userDetails.id)
                                      : changepasswordTab(userDetails),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget profileTab(details) {
    emailController.text = "${details['email'] ?? ''}";
    phoneController.text = "${details['number'] ?? ''}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextRegular(
          text: 'Driver Profile',
          fontSize: 32,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        TextRegular(
            text: 'Manage and secure your account',
            fontSize: 14,
            color: Colors.grey),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(width: 300, child: Divider()),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Username:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: "${details['username'] ?? 'Username'}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Name:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            TextRegular(
              text: "${details['fname'] ?? ''} ${details['lname'] ?? ''}",
              fontSize: 18,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Email:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextRegular(
              text: 'Phone Number:',
              fontSize: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 150,
              child: TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: '',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [
        //     TextRegular(
        //       text: 'Gender:',
        //       fontSize: 12,
        //       color: Colors.grey,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     TextRegular(
        //       text: "${details['gender'] ?? ''}",
        //       fontSize: 18,
        //       color: Colors.black,
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Row(
        //   children: [
        //     TextRegular(
        //       text: 'Date of Birth:',
        //       fontSize: 12,
        //       color: Colors.grey,
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     TextRegular(
        //       text: "${details['birthday'] ?? ''}",
        //       fontSize: 18,
        //       color: Colors.black,
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 30,
        ),
        ButtonWidget(
          radius: 5,
          color: primary,
          fontSize: 14,
          width: 150,
          label: 'Save',
          onPressed: () async {
            showToast('User details updated!');

            await FirebaseFirestore.instance
                .collection('Drivers')
                .doc(details.id)
                .update({
              'number': phoneController.text,
              'email': emailController.text
            });
          },
        ),
      ],
    );
  }

  Widget changepasswordTab(details) {
    return passwordVerified
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextRegular(
                text: 'Security Check',
                fontSize: 32,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Manage and secure your account',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(width: 300, child: Divider()),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      size: 75,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                      text: 'Verification complete!',
                      fontSize: 22,
                      color: Colors.grey,
                    ),
                    TextRegular(
                      text:
                          'For your account security, do not share your password with anyone else.',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Password',
                        controller: passwordController),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        isPassword: true,
                        label: 'Confirm Password',
                        controller: confirmpasswordController),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ButtonWidget(
                        radius: 5,
                        color: primary,
                        fontSize: 14,
                        width: 150,
                        label: 'Confirm',
                        onPressed: () async {
                          var authQuery = AuthQuery();
                          await authQuery.changePassword(
                              details['email'],
                              passwordController.text,
                              confirmpasswordController.text);
                          setState(() {
                            profiletab = true;
                            changepasswordtab = false;
                          });
                          showToast('Password changed succesfully!');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextRegular(
                text: 'Security Check',
                fontSize: 32,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Manage and secure your account',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(width: 300, child: Divider()),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security_outlined,
                      size: 75,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                      text: 'To protect your account, verify your account',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    TextRegular(
                      text: ' and change your password.',
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ButtonWidget(
                  radius: 5,
                  color: primary,
                  fontSize: 14,
                  width: 150,
                  label: 'Change Password',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextBold(
                              text: 'Enter your current password',
                              fontSize: 18,
                              color: Colors.black),
                          content: SizedBox(
                            height: 75,
                            child: TextFieldWidget(
                                isObscure: true,
                                isPassword: true,
                                label: 'Password',
                                controller: passwordController),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  passwordVerified = true;
                                });
                                Navigator.pop(context);
                              },
                              child: TextBold(
                                text: 'Continue',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }

  final maker = TextEditingController();
  final yearModel = TextEditingController();
  final platenumber = TextEditingController();

  int dropValue = 0;

  List<Map<String, String>> listVehicles = [
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
    {
      "name": "6-Wheel Truck Close Type",
      "image": "6-Wheel-Truck-Close-Type.png"
    },
    {
      "name": "10-Wheel Truck Close Type",
      "image": "10-Wheel-Truck-Close-Type.png"
    },
    {"name": "6-Wheel Truck Open Type", "image": "6-Wheel-Truck-Open-Type.png"},
    {
      "name": "10-Wheel Truck Open Type",
      "image": "10-Wheel-Truck-Open-Type.png"
    },
  ];

  String _selectedOption = 'GCash';

  String selectedVehicle = 'Motorcycle';

  Widget vehicles() {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextRegular(
              text: 'My Vehicles',
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextRegular(
                    text: 'Manage your vehicles',
                    fontSize: 14,
                    color: Colors.grey),
                const SizedBox(
                  width: 500,
                ),
                ButtonWidget(
                  height: 35,
                  fontSize: 14,
                  color: Colors.black,
                  radius: 0,
                  width: 100,
                  label: 'Add vehicle',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TextRegular(
                            text: 'Adding Vehicle',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          content:
                              StatefulBuilder(builder: (context, setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                      underline: const SizedBox(),
                                      value: dropValue,
                                      items: [
                                        for (int i = 0;
                                            i < listVehicles.length;
                                            i++)
                                          DropdownMenuItem(
                                            value: i,
                                            onTap: () {
                                              setState(() {
                                                selectedVehicle =
                                                    listVehicles[i]['name']!;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextRegular(
                                                text:
                                                    'Type: ${listVehicles[i]['name']}',
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          dropValue =
                                              int.parse(value.toString());
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                  label: 'Maker',
                                  controller: maker,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                  label: 'Year Model',
                                  controller: yearModel,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldWidget(
                                  label: 'Plate Number',
                                  controller: platenumber,
                                ),
                              ],
                            );
                          }),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: TextRegular(
                                text: 'Close',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                addVehicles(selectedVehicle, maker.text,
                                    yearModel.text, platenumber.text);
                                Navigator.pop(context);
                              },
                              child: TextRegular(
                                text: 'Continue',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(width: 300, child: Divider()),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Vehicles')
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text('Error'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                    );
                  }

                  final data = snapshot.requireData;
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: 300,
                      child: DataTable(columns: [
                        DataColumn(
                          label: TextBold(
                            text: 'Type',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        DataColumn(
                          label: TextBold(
                            text: 'Maker',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        DataColumn(
                          label: TextBold(
                            text: 'Year Model',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        DataColumn(
                          label: TextBold(
                            text: 'Plate Number',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        DataColumn(
                          label: TextBold(
                            text: '',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ], rows: [
                        for (int i = 0; i < data.docs.length; i++)
                          DataRow(cells: [
                            DataCell(
                              TextRegular(
                                text: data.docs[i]['type'],
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                color: Colors.black,
                                fontSize: 14,
                                text: data.docs[i]['yearmodel'],
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                color: Colors.black,
                                fontSize: 14,
                                text: data.docs[i]['maker'],
                              ),
                            ),
                            DataCell(
                              TextRegular(
                                color: Colors.black,
                                fontSize: 14,
                                text: data.docs[i]['platenumber'],
                              ),
                            ),
                            DataCell(SizedBox(
                              width: 150,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      yearModel.text =
                                          data.docs[i]['yearmodel'];
                                      maker.text = data.docs[i]['maker'];
                                      platenumber.text =
                                          data.docs[i]['platenumber'];
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: TextRegular(
                                              text: 'Updating Vehicle',
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                            content: StatefulBuilder(
                                                builder: (context, setState) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: DropdownButton(
                                                        underline:
                                                            const SizedBox(),
                                                        value: dropValue,
                                                        items: [
                                                          for (int i = 0;
                                                              i <
                                                                  listVehicles
                                                                      .length;
                                                              i++)
                                                            DropdownMenuItem(
                                                              value: i,
                                                              onTap: () {
                                                                setState(() {
                                                                  selectedVehicle =
                                                                      listVehicles[
                                                                              i]
                                                                          [
                                                                          'name']!;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child:
                                                                    TextRegular(
                                                                  text:
                                                                      'Type: ${listVehicles[i]['name']}',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropValue =
                                                                int.parse(value
                                                                    .toString());
                                                          });
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFieldWidget(
                                                    label: 'Maker',
                                                    controller: maker,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFieldWidget(
                                                    label: 'Year Model',
                                                    controller: yearModel,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFieldWidget(
                                                    label: 'Plate Number',
                                                    controller: platenumber,
                                                  ),
                                                ],
                                              );
                                            }),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: TextRegular(
                                                  text: 'Close',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Vehicles')
                                                      .doc(data.docs[i].id)
                                                      .update({
                                                    'maker': maker.text,
                                                    'yearmodel': yearModel.text,
                                                    'platenumber':
                                                        platenumber.text,
                                                    'type': selectedVehicle,
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: TextRegular(
                                                  text: 'Update',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: TextBold(
                                      text: 'Update',
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Delete Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this vehicle?',
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
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Vehicles')
                                                    .doc(data.docs[i].id)
                                                    .delete();

                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: TextBold(
                                      text: 'Delete',
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ])
                      ]),
                    ),
                  );
                })
          ]),
    );
  }

  List subs = [
    {
      'title': ' 1 Month Subscription',
      'details': 'Php 1,500 per month. Cancel anytime.',
      'others': '✓ Includes one vehicles'
    },
    {
      'title': '6 Months Subscription',
      'details': 'Php 8,550 per month. Cancel anytime.',
      'others': '✓ Includes one vehicles\n✓ Saved Php 450'
    },
    {
      'title': '9 Months Subscription',
      'details': 'Php 12,555 per month. Cancel anytime.',
      'others': '✓ Includes one vehicles\n✓ Saved Php 945'
    },
    {
      'title': '12 Months Subscription',
      'details': 'Php 16,200 per month. Cancel anytime.',
      'others': '✓ Includes one vehicles\n✓ Saved Php 1,800'
    }
  ];

  Widget subscriptiontab(Map<String, dynamic> plan, String id) {
    print(plan);
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextRegular(
              text: 'Subscription',
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextRegular(
                    text: 'Manage your account subscription and settings',
                    fontSize: 14,
                    color: Colors.grey),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(width: 300, child: Divider()),
            const SizedBox(
              height: 20,
            ),
            TextRegular(
              text: 'Your Subscription',
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(width: 300, child: Divider()),
            const SizedBox(
              height: 20,
            ),
            plan.isEmpty
                ? Center(
                    child: TextBold(
                      text: 'No Subscription!',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 300,
                      height: 250,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBold(
                              text: plan['title'],
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            TextRegular(
                              text: plan['details'],
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextRegular(
                                  text: 'Billing Start Date',
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                TextRegular(
                                  text: DateFormat.yMMMd()
                                      .format(plan['dateTime'].toDate()),
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextRegular(
                                  text: 'Mode',
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                TextRegular(
                                  text: plan['payment'],
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextRegular(
                              text: plan['others'],
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ButtonWidget(
                              color: Colors.red,
                              radius: 10,
                              width: 100,
                              height: 40,
                              fontSize: 12,
                              label: 'Cancel Plan',
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Cancel Plan Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to cancel this plan?',
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
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Drivers')
                                                    .doc(id)
                                                    .update({'plan': {}});
                                                showToast(
                                                    'Plan cancelled succesfully!');
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(width: 300, child: Divider()),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 500,
              width: 750,
              child: GridView.builder(
                itemCount: subs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBold(
                              text: subs[index]['title'],
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            TextRegular(
                              text: subs[index]['details'],
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextRegular(
                              text: subs[index]['others'],
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ButtonWidget(
                              color: Colors.blue,
                              radius: 10,
                              width: 100,
                              height: 40,
                              fontSize: 12,
                              label: 'Select Plan',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                width: 300,
                                                height: 400,
                                                decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextBold(
                                                        text: subs[index]
                                                            ['title'],
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                      ),
                                                      TextRegular(
                                                        text: subs[index]
                                                            ['details'],
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                      const Divider(
                                                        color: Colors.white,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextRegular(
                                                            text:
                                                                'Billing Date',
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                          TextRegular(
                                                            text: DateFormat(
                                                                    'MM/dd/yyyy')
                                                                .format(DateTime
                                                                    .now())
                                                                .toString(),
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextRegular(
                                                        text: subs[index]
                                                            ['others'],
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            RadioListTile(
                                                              title: const Text(
                                                                'GCash',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              value: 'GCash',
                                                              groupValue:
                                                                  _selectedOption,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _selectedOption =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile(
                                                              title: const Text(
                                                                'Maya',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              value: 'Maya',
                                                              groupValue:
                                                                  _selectedOption,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  _selectedOption =
                                                                      value!;
                                                                });
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 25,
                                                      ),
                                                      ButtonWidget(
                                                        color: Colors.green,
                                                        radius: 10,
                                                        width: 100,
                                                        height: 40,
                                                        fontSize: 12,
                                                        label: 'Continue',
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Drivers')
                                                              .doc(id)
                                                              .update({
                                                            'plan': {
                                                              'title':
                                                                  subs[index]
                                                                      ['title'],
                                                              'details': subs[
                                                                      index]
                                                                  ['details'],
                                                              'others': subs[
                                                                      index]
                                                                  ['others'],
                                                              'payment':
                                                                  _selectedOption,
                                                              'dateTime':
                                                                  DateTime
                                                                      .now(),
                                                            }
                                                          });
                                                          showToast(
                                                              'Plan updated succesfully!');
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
    );
  }
}
