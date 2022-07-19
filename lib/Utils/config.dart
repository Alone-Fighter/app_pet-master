import 'dart:ui';

import 'package:flutter/material.dart';

class Config {

  // color
  static Color blue = const Color(0xff2596be);
  static Color white = const Color(0xfffdfeff);
  static Color gray =  Colors.black.withOpacity(.4);

  // size
  static double buttonH = 60;

  // Text
  static textStyleB(Color color)=> TextStyle(color: color ,fontSize: 23);
  static textStyleH(Color color)=> TextStyle(color: color ,fontSize: 18);
  static textStyleM(Color color)=> TextStyle(color: color ,fontSize: 16);
  static textStyleS(Color color)=> TextStyle(color: color ,fontSize: 14);

}