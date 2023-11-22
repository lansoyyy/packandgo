// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';

import '../home_screen.dart';

class DetailsTab extends StatefulWidget {
  const DetailsTab({super.key});

  @override
  State<DetailsTab> createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          dynamic data = snapshot.data;

          if (!isLoading) {
            newContactnumberController.text = data['number'];
            newEmailController.text = data['email'];
            isLoading = true;
          }
          return Center(
              child: SingleChildScrollView(
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
                          text: 'Vehicle Type: $vehicle',
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
                          text: 'Pick-up: ${pickupController.text}',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextRegular(
                          text: 'Drop-off: ${dropoffController.text}',
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
                          text: 'Name: ${data['fname']} ${data['lname']}',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextRegular(
                          text: newContactnumberController.text != ''
                              ? 'Contact Number: ${newContactnumberController.text}'
                              : 'Contact Number: ${data['number']}',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextRegular(
                          text: newAlernativcontactnumberController.text != ''
                              ? 'Alternative Contact Number: ${newAlernativcontactnumberController.text}'
                              : 'Alternative Contact Number: ${newAlernativcontactnumberController.text}',
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
                              text: newEmailController.text != ''
                                  ? 'Email: ${newEmailController.text}'
                                  : 'Email: ${data['email']}',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            ButtonWidget(
                              height: 35,
                              color: Colors.amber,
                              radius: 5,
                              width: 80,
                              fontSize: 12,
                              label: 'Update',
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: TextRegular(
                                          text: 'Update your Information',
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFieldWidget(
                                                label: 'Contact Number:',
                                                controller:
                                                    newContactnumberController),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFieldWidget(
                                                label:
                                                    'Alernative Contact Number:',
                                                controller:
                                                    newAlernativcontactnumberController),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFieldWidget(
                                                label: 'Email:',
                                                controller: newEmailController),
                                          ],
                                        ),
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
                                              setState(() {});
                                              // clearing controllers should be done after request booking
                                              // newAlernativcontactnumberController.clear();
                                              // newContactnumberController.clear();
                                              // newEmailController.clear();
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
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
