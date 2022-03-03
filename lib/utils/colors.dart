import 'package:flutter/material.dart';

class ColorWrap {
  static List<Color?> pallette = [
    Colors.blue[200],
    Colors.pink[200],
    Colors.green[200],
    Colors.red[200],
    Colors.cyan[200],
    Colors.purple[200],
  ];

  static Color get(int no) {
    Color? ret = pallette[no % pallette.length];
    if (ret == null) {
      return Colors.blue;
    }
    return ret;
  }
}