import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/queries/queries.dart';
import 'package:packandgo/widgets/chat_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../queries/streamQueries.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/text_widget.dart';
import '../../queries/authQuery.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  String nameSearched = '';
  final searchController = TextEditingController();
  var streamQuery = StreamQuery();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var recordsData = [];
  bool isLoading = false;

  List statuses = ['All', 'Canceled', 'Completed', 'Pending'];

  String status = 'All';
  String option = 'Change of plans';

  List cancelOptions = [
    'Change of plans',
    'Found another moving service',
    'Financial reasons',
    'Personal emergency',
    'Unexpected circumstances',
    'Moving plans postponed',
    'Moving plans canceled',
    'Others',
  ];

  int dropValue = 0;
  int dropValue1 = 0;
  var userDetails;

  final othersController = TextEditingController();
  @override
  void initState() {
    getUserDEtails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primary,
        child: const Icon(
          Icons.message_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: ListView.separated(
                      itemCount: 100,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return const ChatWidget();
                                },
                              );
                            },
                            leading: const CircleAvatar(
                              minRadius: 35,
                              maxRadius: 35,
                              backgroundImage: AssetImage(
                                'assets/images/profile.png',
                              ),
                            ),
                            title: TextBold(
                                text: 'Message here...',
                                fontSize: 14,
                                color: Colors.black),
                            subtitle: TextRegular(
                                text: 'John Doe',
                                fontSize: 12,
                                color: Colors.grey),
                            trailing: TextRegular(
                                text: 'Date and Time',
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: !isLoading && userDetails != null
          ? Column(
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
                        GestureDetector(
                          onTap: () {},
                          child: TextBold(
                            text: 'Pack & Go',
                            fontSize: 38,
                            color: Colors.white,
                          ),
                        ),
                        Wrap(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.driverprofilescreen);
                              },
                              child: TextRegular(
                                text: 'PROFILE',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logout Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
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
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                final SharedPreferences
                                                    userData =
                                                    await SharedPreferences
                                                        .getInstance();
                                                var usthQuery = AuthQuery();
                                                await usthQuery.signOut();
                                                await userData.clear();
                                                Navigator.pushNamed(context,
                                                    Routes.driverloginpage);
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
                              child: TextRegular(
                                text: 'LOGOUT',
                                fontSize: 16,
                                color: Colors.white,
                              ),
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
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              nameSearched = value;
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search by delivery info',
                            hintStyle: TextStyle(fontFamily: 'QRegular'),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          controller: searchController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBold(
                        text: 'Records',
                        fontSize: 24,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // this code is is for as is base on the design
                                // this table dont need reload becaus eit is stream it always listen to the database
                                setState(() => isLoading = true);
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() => isLoading = false);
                                });
                              },
                              icon: const Icon(
                                Icons.refresh,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
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
                                  for (int i = 0; i < statuses.length; i++)
                                    DropdownMenuItem(
                                      value: i,
                                      onTap: () {
                                        setState(() {
                                          status = statuses[i];
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextRegular(
                                          text: 'Status: ${statuses[i]}',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    dropValue = int.parse(value.toString());
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: streamQuery.getMultipleSnapsByData(roots: [
                    // {"root": "user-details", "key": "uid", "value": _auth.currentUser!.uid},
                    {
                      "root": "records",
                      "key": "vehicle-type",
                      "value": (userDetails["vehicle_type"]).toString()
                    },
                  ]),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }

                    if (snapshot.hasData) {
                      final data = snapshot.data;
                      var snapshotList = snapshot.data as List<QuerySnapshot>;
                      recordsData = [];
                      for (var doc in snapshotList[0].docs) {
                        var value = doc.data()! as Map;
                        value['id'] = doc.id;

                        filterData() {
                          String searchString = value.toString();
                          if (searchController.text.isNotEmpty) {
                            if (searchString.contains(searchController.text)) {
                              recordsData.add(value);
                            }
                          } else {
                            recordsData.add(value);
                          }
                        }

                        switch (status) {
                          case 'All':
                            filterData();
                            break;
                          case 'Canceled':
                            if (value['booking-status'] == 'canceled') {
                              filterData();
                            }
                            break;
                          case 'Completed':
                            if (value['booking-status'] == 'completed') {
                              filterData();
                            }
                            break;
                          case 'Pending':
                            if (value['booking-status'] == 'pending') {
                              filterData();
                            }
                            break;
                          default:
                        }
                      }

                      return DataTable(
                        dataRowHeight: 100,
                        columns: [
                          DataColumn(
                            label: TextBold(
                              text: 'Status',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Delivery Rate',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Route',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Driver/Mover',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Type',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: 'Price',
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          DataColumn(
                            label: TextBold(
                              text: '',
                              fontSize: 0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                        rows: dataRows(recordsData),
                      );
                    } else {
                      return const Center(child: Text("No data available!"));
                    }
                  },
                ),
              ],
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  List<DataRow> dataRows(data) {
    List<DataRow> dataRows = [];
    data.forEach((value) {
      var status = value['booking-status'].toString().toLowerCase();
      dataRows.add(
        DataRow(
          cells: [
            DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: status == "pending"
                          ? Colors.orange
                          : status == "cancelled"
                              ? Colors.red
                              : status == "completed"
                                  ? Colors.green
                                  : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 30,
                    width: 125,
                    child: Center(
                      child: TextRegular(
                          text: value['booking-status'],
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                  TextRegular(
                      text: value['booking-id'],
                      fontSize: 14,
                      color: Colors.black),
                ],
              ),
            ),
            DataCell(
              TextRegular(
                  text: 'July 02, 2023 (3:30pm - 4:30pm)',
                  fontSize: 14,
                  color: Colors.black),
            ),
            DataCell(
              TextRegular(
                  text: value['drop-off-location'],
                  fontSize: 14,
                  color: Colors.black),
            ),
            DataCell(
              TextRegular(
                  text: value['name'], fontSize: 14, color: Colors.black),
            ),
            DataCell(
              TextRegular(
                  text: value['vehicle-type'],
                  fontSize: 14,
                  color: Colors.black),
            ),
            DataCell(
              TextRegular(
                  text: value['price'], fontSize: 14, color: Colors.black),
            ),
            DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return cancelDialog(value);
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 30,
                      width: 125,
                      child: Center(
                        child: TextRegular(
                            text: 'Cancel', fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: viewDetailDialog(),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    confirmationDialog(value);
                                  },
                                  child: TextRegular(
                                    text: 'Complete',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: TextRegular(
                                    text: 'Close',
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 30,
                      width: 125,
                      child: Center(
                        child: TextRegular(
                            text: 'View', fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    return dataRows;
  }

  viewDetailDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey,
                    ),
                    height: 50,
                    child: Center(
                      child: TextRegular(
                          text: 'Booking Details',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextRegular(
                      text: 'Vehicle Type: Vehicle Type',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Date and Time: ${DateTime.now()}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Drop off Location',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Pick-up: Pick up Location',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Drop-off: Drop off Location',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Notes to driver: Sample note details',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: 400,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.grey,
                    ),
                    height: 50,
                    child: Center(
                      child: TextRegular(
                          text: 'Your Information',
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextRegular(
                      text: 'Name: John Doe',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Contact Number: 09090104355',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Alternative Contact Number: 09639530422',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextRegular(
                          text: 'Email: doe@gmail.com',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }

  cancelDialog(data) {
    return AlertDialog(
      title: TextRegular(
        text: 'Cancel Booking',
        fontSize: 18,
        color: Colors.black,
      ),
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextRegular(
              text: 'Cancellation details',
              fontSize: 14,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButton(
                  underline: const SizedBox(),
                  value: dropValue1,
                  items: [
                    for (int i = 0; i < cancelOptions.length; i++)
                      DropdownMenuItem(
                        value: i,
                        onTap: () {
                          setState(() {
                            option = cancelOptions[i];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextRegular(
                            text: '${cancelOptions[i]}',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropValue1 = int.parse(value.toString());
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            option == 'Others'
                ? TextFieldWidget(
                    label: 'Please specify your reason',
                    controller: othersController)
                : const SizedBox(),
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
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: SizedBox(
                      width: 300,
                      child: TextRegular(
                          text:
                              'Are you sure you want to cancel the moving service? Please note that this cannot be undone once it is canceled. Three consecutive canceled move service within 24 hours of the scheduled day may require you to pay 50% deposit fee of the agreed price on your next move service booking.',
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: TextRegular(
                          text: 'Close',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var query = Queries();
                          await query.update(
                            'records',
                            data["id"],
                            {
                              'booking-status': 'canceled',
                              'cancel-reasons': option == 'Others'
                                  ? othersController.text
                                  : option,
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: TextRegular(
                          text: 'Continue',
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  );
                });
          },
          child: TextRegular(
            text: 'Continue',
            fontSize: 18,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  confirmationDialog(data) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                'Booking Confirmation',
                style:
                    TextStyle(fontFamily: 'QBold', fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'Are you sure you want to confirm this booking?',
                style: TextStyle(fontFamily: 'QRegular'),
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Close',
                    style: TextStyle(
                        fontFamily: 'QRegular', fontWeight: FontWeight.bold),
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    var query = Queries();
                    await query.update(
                      'records',
                      data["id"],
                      {
                        'booking-status': 'Completed',
                        // 'cancel-reasons': option == 'Others' ? othersController.text : option,
                      },
                    );
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontFamily: 'QRegular', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }

  Future getUserDEtails() async {
    final SharedPreferences userData = await SharedPreferences.getInstance();
    var details = userData.getString('userDetails');
    userDetails = details != null ? json.decode(details) : null;
    setState(() {});
  }
}
