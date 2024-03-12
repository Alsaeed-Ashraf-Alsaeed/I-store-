import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme {
  static const  Color secondColor = Color.fromARGB(255, 32, 34, 40);
  static const  Color secondColorLighter = Color.fromARGB(255, 22, 30, 30);
  static const mainColor = Colors.white;

  static  TextStyle styleLarge = TextStyle(
      color: secondColor,
      fontSize: 35.r,
      fontWeight: FontWeight.bold);
  static TextStyle styleMedium = TextStyle(
      color: secondColor,
      fontSize: 25.r,
      fontWeight: FontWeight.bold);
  static TextStyle styleSmall = TextStyle(
      color: secondColor,
      fontSize: 18.r,
      fontWeight: FontWeight.bold);
}
