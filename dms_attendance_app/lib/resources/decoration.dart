import 'package:flutter/material.dart';
import 'resources.dart';

class AppDecoration {
  BoxDecoration boxDecoration(
      Color borderColor, Color fillColor, double borderRadius) {
    return BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        color: fillColor);
  }
}
