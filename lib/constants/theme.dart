import 'package:flutter/material.dart';

class AT {
  AT._();
  static const kSpacingUnit = 10;
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color lightText = Color(0xFF4A6572);
  static const Color spacer = Color(0xFFF2F2F2);

}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }


}
