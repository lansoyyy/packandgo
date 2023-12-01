import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packandgo/widgets/textfield_widget.dart';

import '../../../../queries/streamQueries.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/routes.dart';
import '../../../../widgets/chat_widget.dart';
import '../../../../widgets/text_widget.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  String nameSearched = '';
  final searchController = TextEditingController();
  var streamQuery = StreamQuery();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var recordsData = [];
  var convoList = [];
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

  final othersController = TextEditingController();
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
              // print("user data from page $recordsData");
              return Dialog(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Orders')
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
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: SizedBox(
                          width: 400,
                          height: 400,
                          child: ListView.separated(
                            itemCount: recordsData.length,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              final record = convoList[index];
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ChatWidget(
                                          customerData: record,
                                        );
                                      },
                                    );
                                  },
                                  leading: const CircleAvatar(
                                    minRadius: 35,
                                    maxRadius: 35,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'),
                                  ),
                                  title: TextBold(
                                      text: record["convo"][0]["message"],
                                      fontSize: 14,
                                      color: Colors.black),
                                  subtitle: TextRegular(
                                      text: record["name"],
                                      fontSize: 12,
                                      color: Colors.grey),
                                  trailing: TextRegular(
                                      text: record["convo"][0]["date"],
                                      fontSize: 12,
                                      color: Colors.black),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
              );
            },
          );
        },
      ),
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
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.homepage);
                            },
                            child: TextRegular(
                              text: 'New Order',
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
                              borderRadius: BorderRadius.circular(5)),
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
                                )),
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
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
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
                  StreamBuilder<QuerySnapshot>(
                    stream: status == 'All'
                        ? FirebaseFirestore.instance
                            .collection('Orders')
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('Orders')
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .where('status', isEqualTo: status)
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
                        child: DataTable(
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
                                text: 'Delivery Date',
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
                          rows: [
                            for (int i = 0; i < data.docs.length; i++)
                              DataRow(
                                cells: [
                                  DataCell(
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: data.docs[i]['status'] ==
                                                    "Pending"
                                                ? Colors.orange
                                                : data.docs[i]['status'] ==
                                                        "Cancelled"
                                                    ? Colors.red
                                                    : data.docs[i]['status'] ==
                                                            "Completed"
                                                        ? Colors.green
                                                        : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          height: 30,
                                          width: 125,
                                          child: Center(
                                            child: TextRegular(
                                                text: data.docs[i]['status'],
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                        TextRegular(
                                            text: data.docs[i].id,
                                            fontSize: 14,
                                            color: Colors.black),
                                      ],
                                    ),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: DateFormat.yMMMd()
                                            .add_jm()
                                            .format(data.docs[i]['dateAndTime']
                                                .toDate()),
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text:
                                            '${data.docs[i]['pickup']} - ${data.docs[i]['dropoff']}',
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: data.docs[i]['drivername'],
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: data.docs[i]['vehicletype'],
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    TextRegular(
                                        text: 'Price',
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  DataCell(
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return cancelDialog(
                                                      data, data.docs[i].id);
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 30,
                                            width: 125,
                                            child: Center(
                                              child: TextRegular(
                                                  text: 'Cancel',
                                                  fontSize: 14,
                                                  color: Colors.white),
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
                                                    content: viewDetailDialog(
                                                        data.docs[i]),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height: 30,
                                            width: 125,
                                            child: Center(
                                              child: TextRegular(
                                                  text: 'View',
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
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

  viewDetailDialog(data) {
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
                      text: 'Vehicle Type: ${data['vehicletype']}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text:
                          'Date and Time: ${DateFormat.yMMMd().add_jm().format(data['dateTime'].toDate())}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Pick-up: ${data['pickup']}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Drop-off: ${data['dropoff']}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Notes to driver',
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
                      text: 'Name: ${data['drivername']}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Contact Number: ${data['number']}',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                    child: TextRegular(
                      text: 'Alternative Contact Number: ${data['altnumber']}',
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
                          text: 'Email: ${data['email']}',
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

  cancelDialog(data, String id) {
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
                          await FirebaseFirestore.instance
                              .collection('Orders')
                              .doc(id)
                              .update({'status': 'Cancelled'});
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
}
