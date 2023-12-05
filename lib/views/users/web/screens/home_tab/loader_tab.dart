import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  int dropValue2 = 0;

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
            text: 'Would you like to add a helper?',
            fontSize: 22,
            color: Colors.black,
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonWidget(
            textColor: Colors.white,
            color: Colors.green,
            width: 150,
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
          Container(
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButton(
                underline: const SizedBox(),
                value: dropValue2,
                items: [
                  for (int i = 0; i < vehicles.length; i++)
                    DropdownMenuItem(
                      value: i,
                      onTap: () {
                        setState(() {
                          selectedIndex = i;

                          vehicle = vehicles[i]['name']!;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextRegular(
                          text: vehicles[i]['name'].toString(),
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    dropValue2 = int.parse(value.toString());
                  });
                }),
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
            height: 20,
          ),
          GestureDetector(
            // onTap: () async {
            //   await PlacesAutocomplete.show(
            //     context: context,
            //     apiKey: 'AIzaSyDdXaMN5htLGHo8BkCfefPpuTauwHGXItU',
            //     mode: Mode.overlay, // Mode.fullscreen
            //     language: "fr",
            //   );
            // },
            child: Container(
              height: 50,
              width: 500,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                enabled: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.notes),
                  hintText: 'Driver Notes',
                  border: InputBorder.none,
                ),
                controller: notesController,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
