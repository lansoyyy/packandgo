import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../queries/streamQueries.dart';
import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../widgets/text_widget.dart';

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

  List statuses = ['All', 'Cancelled', 'Completed', 'Pending'];

  String status = 'All';

  int dropValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: primary,
          child: const Icon(
            Icons.message_outlined,
            color: Colors.white,
          ),
          onPressed: () {}),
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
                        onPressed: () {},
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
              {
                "root": "user-details",
                "key": "uid",
                "value": _auth.currentUser!.uid
              },
              {"root": "evaluations"},
            ]),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasData) {
                final data = snapshot.data;

                return DataTable(dataRowHeight: 100, columns: [
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
                ], rows: [
                  dataRows()
                ]);
              } else {
                return const Center(child: Text("No data available!"));
              }
            },
          ),
        ],
      ),
    );
  }

  DataRow dataRows() {
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 30,
                width: 125,
                child: Center(
                  child: TextRegular(
                      text: 'Pending', fontSize: 14, color: Colors.white),
                ),
              ),
              TextRegular(
                  text: '2020300527', fontSize: 14, color: Colors.black),
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
              text: 'Cabahug Street - Wilson Street',
              fontSize: 14,
              color: Colors.black),
        ),
        DataCell(
          TextRegular(text: 'John Doe', fontSize: 14, color: Colors.black),
        ),
        DataCell(
          TextRegular(text: 'Motorcycle', fontSize: 14, color: Colors.black),
        ),
        DataCell(
          TextRegular(text: 'Not Set', fontSize: 14, color: Colors.black),
        ),
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
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
                onTap: () {},
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
    );
  }
}
