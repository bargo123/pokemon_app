import 'package:flutter/material.dart';

class CustomTextStyle {
  TextStyle notoSansFont({Color color = Colors.black, double fontSize = 14, FontWeight fontWeight = FontWeight.w500}) {
    return TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight, fontFamily: "NotoSans");
  }
}
