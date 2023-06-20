import 'package:flutter/material.dart';
import 'package:packandgo/widgets/button_widget.dart';
import 'package:packandgo/widgets/text_widget.dart';

class LoaderTab extends StatelessWidget {
  const LoaderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
          onPressed: () {},
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
      ],
    ));
  }
}
