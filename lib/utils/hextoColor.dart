// / Construct a color from a hex code string, of the format #RRGGBB.
import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(2), radix: 16) + 0xFF000000);
}

String colorToHex(Color color) {
  return color.value.toString();
}
