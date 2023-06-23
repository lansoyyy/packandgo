import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';
import 'package:packandgo/widgets/textfield_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';

class DetailsTab extends StatelessWidget {
  DetailsTab({super.key});
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (userDetails != null) {
      isLoading = false;
    } else {
      isLoading = true;
    }
    return !isLoading
        ? Center(
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
                        child: TextRegular(text: 'Booking Details', fontSize: 18, color: Colors.white),
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
                        text: 'Lot 34, Block 19, House 36',
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
                        child: TextRegular(text: 'Your Information', fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextRegular(
                        text: 'Name: ${userDetails['firstname']} ${userDetails['lastname']}',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextRegular(
                        text: 'Contact Number: ${userDetails['contact_number']}',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextRegular(
                        text: 'Alternative Contact Number: ${newAlernativcontactnumberController.text}',
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
                            text: 'Email: ${userDetails['email']}',
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextFieldWidget(label: 'Contact Number:', controller: newContactnumberController),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldWidget(label: 'Alernative Contact Number:', controller: newAlernativcontactnumberController),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldWidget(label: 'Email:', controller: newEmailController),
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
                                            newAlernativcontactnumberController.clear();
                                            newContactnumberController.clear();
                                            newEmailController.clear();
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
          ))
        : Center(child: CircularProgressIndicator());
  }
}
