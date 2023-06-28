import 'package:flutter/material.dart';

import '../../../../widgets/text_widget.dart';
import '../home_screen.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: TextBold(
              text: 'Location Details',
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextRegular(
                text: 'Location A',
                fontSize: 14,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 30,
              ),
              TextRegular(
                text: 'Location B',
                fontSize: 14,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_rounded,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextRegular(
                  text: 'Pick-Up Location',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded),
                hintText: 'Unit or apartment number',
                border: InputBorder.none,
              ),
              controller: pickupController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check1,
                onChanged: (value) {
                  setState(() {
                    check1 = !check1;
                    check2 = false;
                    check3 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Helper needs to use stairs',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check2,
                onChanged: (value) {
                  setState(() {
                    check2 = !check2;
                    check1 = false;
                    check3 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Helper can use the elevator',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check3,
                onChanged: (value) {
                  setState(() {
                    check3 = !check3;
                    check1 = false;
                    check2 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Need to ring doorbell',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: '       Additional Location Address',
                border: InputBorder.none,
              ),
              controller: pickupAdditionalController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_rounded,
                ),
                const SizedBox(
                  width: 20,
                ),
                TextRegular(
                  text: 'Drop-Off Location',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded),
                hintText: 'Unit or apartment number',
                border: InputBorder.none,
              ),
              controller: pickupController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check1,
                onChanged: (value) {
                  setState(() {
                    check1 = !check1;
                    check2 = false;
                    check3 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Helper needs to use stairs',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check2,
                onChanged: (value) {
                  setState(() {
                    check2 = !check2;
                    check1 = false;
                    check3 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Helper can use the elevator',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: check3,
                onChanged: (value) {
                  setState(() {
                    check3 = !check3;
                    check1 = false;
                    check2 = false;
                  });
                },
              ),
              const SizedBox(
                width: 400,
                child: Text(
                  'Need to ring doorbell',
                  style: TextStyle(fontFamily: 'QRegular'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: '       Additional Location Address',
                border: InputBorder.none,
              ),
              controller: dropoffAdditionalController,
            ),
          ),
        ],
      ),
    );
  }
}
