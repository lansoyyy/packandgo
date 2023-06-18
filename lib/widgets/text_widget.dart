// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class TextRegular extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;

  TextRegular({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color, fontFamily: 'QRegular'),
    );
  }
}

class TextBold extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;

  TextBold({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color, fontFamily: 'QBold', fontWeight: FontWeight.w900),
    );
  }
}

Widget textWidget({
  required text,
  isBold = false,
  isBullet = false,
  caps = false,
  vGap = 10.0,
  hyGap = 0.0,
}) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: vGap, horizontal: hyGap),
      child: Row(
        children: [
          if (isBullet)
            Text(
              "    •  ",
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          Container(
            width: 500,
            child: Text(
              caps ? text.toString().toUpperCase() : text,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          )
        ],
      ));
}
