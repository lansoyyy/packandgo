import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:packandgo/utils/colors.dart';
import 'package:packandgo/views/users/web/screens/home_screen.dart';

import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/toast_widget.dart';

class LoaderTab extends StatefulWidget {
  const LoaderTab({super.key});

  @override
  State<LoaderTab> createState() => _LoaderTabState();
}

class _LoaderTabState extends State<LoaderTab> {
  final scrollController = ScrollController();

  int dropValue = 0;
  int dropValue1 = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
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
              showToast('Selected');
              setState(() {
                addLoaderAndUnloader =
                    true; // Update the variable when "Yes" button is pressed
              });
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
              showToast('Selected');
              setState(() {
                addLoaderAndUnloader =
                    false; // Update the variable when "No" button is pressed
              });
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
              showToast('Selected');
              setState(() {
                addRearranger = true;
              });
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
              showToast('Selected');
              setState(() {
                addRearranger = false;
              });
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
                  bool isSelected = selectedIndex ==
                      index; // Check if the current item is selected
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index; // Update the selected index
                        vehicle = vehicles[index]['name']!;
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        height: 190,
                        width: 200,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue
                              : Colors
                                  .white, // Apply different color if selected
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
                              color: isSelected
                                  ? Colors.white
                                  : Colors
                                      .black, // Apply different text color if selected
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextBold(
            text: 'Select Business Provider:',
            fontSize: 18,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Business').snapshots(),
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

                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                      underline: const SizedBox(),
                      value: dropValue1,
                      items: [
                        for (int i = 0; i < data.docs.length; i++)
                          DropdownMenuItem(
                            value: i,
                            onTap: () {
                              setState(() {
                                businessname = data.docs[i]['fname'] +
                                    ' ' +
                                    data.docs[i]['lname'];
                                businessid = data.docs[i].id;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextRegular(
                                text:
                                    'Name: ${data.docs[i]['fname'] + ' ' + data.docs[i]['lname']}',
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
                );
              }),
          const SizedBox(
            height: 10,
          ),
          TextBold(
            text: 'Select a Driver:',
            fontSize: 18,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Drivers').snapshots(),
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

                return Container(
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton(
                      underline: const SizedBox(),
                      value: dropValue,
                      items: [
                        for (int i = 0; i < data.docs.length; i++)
                          DropdownMenuItem(
                            value: i,
                            onTap: () {
                              setState(() {
                                drivername = data.docs[i]['fname'] +
                                    ' ' +
                                    data.docs[i]['lname'];
                                driverid = data.docs[i].id;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextRegular(
                                text:
                                    'Driver: ${data.docs[i]['fname'] + ' ' + data.docs[i]['lname']}',
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
                );
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
