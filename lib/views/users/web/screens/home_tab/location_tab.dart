import 'package:flutter/material.dart';

import '../../../../../widgets/text_widget.dart';
import '../home_screen.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  List<bool> selectedChoices = [false, false, false];
  List<bool> selectedChoices1 = [false, false, false];
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
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text('Helper needs to use stairs'),
                  value: selectedChoices[0],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices[0] = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Helper can use the elevator'),
                  value: selectedChoices[1],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices[1] = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Need to ring doorbell'),
                  value: selectedChoices[2],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices[2] = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
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
              controller: dropoffController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text('Helper needs to use stairs'),
                  value: selectedChoices1[0],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices1[0] = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Helper can use the elevator'),
                  value: selectedChoices1[1],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices1[1] = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Need to ring doorbell'),
                  value: selectedChoices1[2],
                  onChanged: (value) {
                    setState(() {
                      selectedChoices1[2] = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
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
