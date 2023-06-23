import 'package:flutter/material.dart';

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
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DataTable(dataRowHeight: 100, columns: [
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
            DataRow(
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
                              text: 'Pending',
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                      TextRegular(
                          text: '2020300527',
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
                      text: 'Cabahug Street - Wilson Street',
                      fontSize: 14,
                      color: Colors.black),
                ),
                DataCell(
                  TextRegular(
                      text: 'John Doe', fontSize: 14, color: Colors.black),
                ),
                DataCell(
                  TextRegular(
                      text: 'Motorcycle', fontSize: 14, color: Colors.black),
                ),
                DataCell(
                  TextRegular(
                      text: 'Not Set', fontSize: 14, color: Colors.black),
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
          ])
        ],
      ),
    );
  }
}
