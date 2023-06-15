// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';

showSnackBar({required context, required text, duration = 10}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: duration),
      content: Text(text),
    ),
  );
}

formDialog({
  required title,
  required button1,
  required button2,
  required context,
  required onPressedNo,
  required onPressedYes,
  required formData,
  required size,
  content,
  barrierDismissible = false,
  color = Colors.black,
  validator,
  hint = "",
  fontWeight = FontWeight.normal,
  fontSize = 15.0,
  dialogHeight = 0,
  setstate,
}) async {
  List<Widget> formFields = [];

  formData.forEach((data) {
    formFields.add(Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: labelText(label: data['label']),
        ),
        inputField(
          controller: data['controller'],
          validator: validator,
          isDense: true,
          hasBorder: false,
          fieldColor: Colors.indigo.shade50,
        ),
      ],
    ));
  });
  AlertDialog alert = AlertDialog(
    title: Text(
      "${title.toUpperCase()}",
      style: TextStyle(
          color: Colors.black, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: TextAlign.center,
    ),
    content: SizedBox(
        height: dialogHeight != 0 ? dialogHeight : size.height * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: formFields,
          ),
        )),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.grey.shade600,
              elevation: 3,
              minimumSize: Size(100, 30),
            ),
            onPressed: onPressedNo,
            child: Text("${button1.toUpperCase()}"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.indigo,
              elevation: 3,
              minimumSize: Size(100, 30),
            ),
            onPressed: onPressedYes,
            child: Text("${button2.toUpperCase()}"),
          ),
        ],
      ),
      SizedBox(height: 20),
    ],
  );
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Theme(
        data: ThemeData(
          dialogBackgroundColor: Colors.white,
        ),
        child: alert,
      ),
    ),
  );
}

Widget menuIcon({required onSelected, isProfilePage = false}) {
  return PopupMenuButton(
    icon: Icon(Icons.account_circle_outlined),
    onSelected: onSelected,
    itemBuilder: (BuildContext context) => [
      if (!isProfilePage)
        PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Text('Profile'),
              SizedBox(width: 5),
              Icon(
                Icons.account_circle,
                color: Colors.grey,
              )
            ],
          ),
        ),
      PopupMenuItem(
        value: 'logout',
        child: Row(
          children: [
            Text('Logout'),
            SizedBox(width: 5),
            Icon(
              Icons.exit_to_app,
              color: Colors.grey,
            )
          ],
        ),
      ),
    ],
  );
}

Widget dropdownMenu({
  required dataSelected,
  required dataSelections,
  required onChanged,
  fieldColor = Colors.white,
  isDense = true,
  hasBorder = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: 8.0, vertical: isDense && !kIsWeb ? 5.0 : 0.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: fieldColor,
      border: hasBorder ? Border.all(color: Colors.indigo, width: 1.0) : null,
    ),
    child: Row(
      children: [
        SizedBox(width: 8),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: dataSelected,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              iconSize: 30,
              elevation: 8,
              onChanged: onChanged,
              isDense: isDense,
              items:
                  dataSelections.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value.toString(),
                  child: Text(value.toString()),
                );
              }).toList(),
              selectedItemBuilder: (BuildContext context) {
                return dataSelections.map<Widget>((String value) {
                  return Text(
                    value.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: !isDense
                        ? StrutStyle(
                            height: 2.5,
                          )
                        : null,
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget dropdownMenuMap({
//   required dataSelected,
//   required List<ObjectModel> dataSelections,
//   required onChanged,
//   fieldColor: Colors.white,
//   isDense: true,
//   hasBorder: false,
// }) {
//   return Container(
//     padding: EdgeInsets.symmetric(
//         horizontal: 8.0, vertical: isDense && !kIsWeb ? 5.0 : 0.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5.0),
//       color: fieldColor,
//       border: hasBorder ? Border.all(color: Colors.indigo, width: 1.0) : null,
//     ),
//     child: Row(
//       children: [
//         SizedBox(width: 8),
//         Expanded(
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<ObjectModel>(
//               isExpanded: true,
//               value: dataSelected,
//               icon: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.black,
//               ),
//               iconSize: 30,
//               elevation: 8,
//               onChanged: onChanged,
//               isDense: isDense,
//               items: dataSelections
//                   .map<DropdownMenuItem<ObjectModel>>((ObjectModel value) {
//                 // Map<String, dynamic> dataItem = value as Map<String, dynamic>;
//                 return DropdownMenuItem<ObjectModel>(
//                   value: value,
//                   child: Text(value.value.toString()),
//                 );
//               }).toList(),
//               selectedItemBuilder: (BuildContext context) {
//                 return dataSelections.map<Widget>((ObjectModel value) {
//                   return Text(
//                     value.value.toString(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     strutStyle: !isDense
//                         ? StrutStyle(
//                             height: 2.5,
//                           )
//                         : null,
//                   );
//                 }).toList();
//               },
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

Widget labelText({
  required label,
  isRequired = false,
  textColor = Colors.black,
  color = Colors.red,
  fontSize = 14.0,
  bottomMargin = 5.0,
  topMargin = 10.0,
}) {
  return Container(
    // height: 23,
    margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin),
    child: Text.rich(
      TextSpan(
        text: label,
        children: <InlineSpan>[
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(color: color),
          )
        ],
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    ),
  );
}

Widget sortWidget({
  required onChanged,
  required sortBySelected,
  required sortBySelection,
  fontSize = 16.0,
  borderRadius = 5.0,
  hasBorder = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 30,
    decoration: BoxDecoration(
      border: hasBorder ? Border.all(color: Colors.indigo) : null,
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Icon(Icons.sort, color: Colors.indigo),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              value: sortBySelected,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.indigo,
              ),
              isDense: true,
              elevation: 8,
              onChanged: onChanged,
              items: sortBySelection.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget errorCard({required errorMessage}) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 30),
    color: Colors.white,
    child: Container(
      width: 400,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(errorMessage),
      ),
    ),
  );
}

confirmDialog({
  required title,
  required content,
  required button1,
  required button2,
  required context,
  barrierDismissible = false,
  required onPressedNo,
  required onPressedYes,
  fontWeight = FontWeight.normal,
}) async {
  AlertDialog alert = AlertDialog(
    title: Text(
      "${title.toUpperCase()}",
      style: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    ),
    content: Text(
      "$content",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                backgroundColor: Colors.grey,
                elevation: 3,
                minimumSize: Size(100, 30)),
            onPressed: onPressedNo,
            child: Text("${button1.toUpperCase()}"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              backgroundColor: Colors.indigo,
              elevation: 3,
              minimumSize: Size(100, 30),
            ),
            onPressed: onPressedYes,
            child: Text("${button2.toUpperCase()}"),
          ),
        ],
      ),
    ],
  );
  return await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: alert,
    ),
  );
}

Widget drawer({
  required dashboard,
  required evaluationAccoess,
  required schools,
  required schoolAdmin,
  required teachers,
  required percentageDistribution,
  context,
}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: kIsWeb ? 100 : 130,
          child: DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'T-SET',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  "Teacher's Self Evaluation Tool",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to Dashboard',
              child: Row(
                children: [
                  Icon(Icons.dashboard_outlined),
                  SizedBox(width: 10),
                  Text("Dashboard"),
                ],
              ),
            ),
          ),
          onTap: dashboard,
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to Evaluation Access Page',
              child: Row(
                children: [
                  Icon(Icons.checklist_outlined),
                  SizedBox(width: 10),
                  Text("Evaluation Access"),
                ],
              ),
            ),
          ),
          onTap: evaluationAccoess,
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to Schools Page',
              child: Row(
                children: [
                  Icon(Icons.business_outlined),
                  SizedBox(width: 10),
                  Text("Schools"),
                ],
              ),
            ),
          ),
          onTap: schools,
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to School Head Administrators Accounts"',
              child: Row(
                children: [
                  Icon(Icons.people_outlined),
                  SizedBox(width: 10),
                  Text("School Head Administrators"),
                ],
              ),
            ),
          ),
          onTap: schoolAdmin,
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to Teachers Accounts',
              child: Row(
                children: [
                  Icon(Icons.school_outlined),
                  SizedBox(width: 10),
                  Text("Teachers"),
                ],
              ),
            ),
          ),
          onTap: teachers,
        ),
        ListTile(
          title: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: 'Go to Percentage Distribution',
              child: Row(
                children: [
                  Icon(Icons.query_stats_outlined),
                  SizedBox(width: 10),
                  Text("Percentage Distribution"),
                ],
              ),
            ),
          ),
          onTap: percentageDistribution,
        ),
      ],
    ),
  );
}

Widget buttonWidget({
  required onPressed,
  required buttonName,
  color = Colors.indigo,
  fontSize = 15.0,
  isUpperCase = false,
  width = 100.0,
  height = 30.0,
  borderRadius = 8.0,
  alignment = Alignment.center,
  xpadding = 10.0,
  ypadding = 0.0,
}) {
  return Align(
    alignment: alignment,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: xpadding, vertical: ypadding),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // elevation: 3,E
        minimumSize: Size(width, height),
      ),
      onPressed: onPressed,
      child: Text(
        isUpperCase ? buttonName.toUpperCase() : buttonName,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: fontSize),
      ),
    ),
  );
}

Widget infoCard({
  required message,
  required infoType,
}) {
  String setImage() {
    switch (infoType) {
      case "no-evaluation-access":
        return 'assets/images/evaluation_not_available.png';
      case "evaluation-done":
        return 'assets/images/check_evaluation.png';
      default:
        return "";
    }
  }

  return Card(
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 30),
    color: Colors.white, //Color.fromARGB(255, 224, 238, 238).withOpacity(0.4),
    child: Container(
      width: 400,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              setImage(),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 30),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

showAlertDialog(
    {@required context,
    @required title,
    content = const SizedBox(),
    barrierDismissible = true,
    actions = ''}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: title,
    content: content,
    actions: actions == ''
        ? [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.indigo,
                    elevation: 3,
                    minimumSize: Size(100, 30),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          ]
        : actions,
  );
  // show the dialog
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () async => barrierDismissible, child: alert);
    },
  );
}

Widget titleText({
  required title,
  padding = const EdgeInsets.symmetric(vertical: 20),
}) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: padding,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
