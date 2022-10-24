import 'package:flutter/cupertino.dart';

import 'colors.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular style
TextStyle getRegularStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w400, color);
}

// light style
TextStyle getLightStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w300, color);
}

// medium style
TextStyle getMediumStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w500, color);
}

// bold style
TextStyle getBoldStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.bold, color);
}

// semiBold style
TextStyle getSemiBoldStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeight.w600, color);
}

BoxDecoration getBoxDecorationStyle() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColor.privateBlue.withOpacity(0.8),
        AppColor.white,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
