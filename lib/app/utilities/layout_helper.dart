import 'package:flutter/material.dart';

EdgeInsets stdPadding(context) {
  return EdgeInsets.only(top: 16, left: 16.0, right: 16.0);
}

EdgeInsets padding16 = EdgeInsets.all(16);

EdgeInsets containerPadding = EdgeInsets.fromLTRB(8, 12, 8, 12);
EdgeInsets containerMargin = EdgeInsets.fromLTRB(6, 4, 6, 4);

BorderRadius radius8 = BorderRadius.all(Radius.circular(8.0));
BorderRadius radius10 = BorderRadius.all(Radius.circular(10.0));

double barcode_icon_size() {
  return 20.0;
}

double seperatorLayoutHeight = 3;

class LayoutHelper {
  static final double idealSquareSize = dp(70);
  static final double potraitMinWidth = 300.0;
  static final double dialogMaxWidth = dp(300.0);
  static final double potraitMaxWidth = 500.0; //just for phone that is about to be landscape

  static final double _designWidth = 480;
  static final double _designHeight = 853;

  static double screenWidth;
  static double screenHeight;

}

double dp(double px) {
  if (px == null) return px;

  if (LayoutHelper.screenWidth == null || LayoutHelper.screenHeight == null) return px;

  return px *
      (LayoutHelper.screenWidth * LayoutHelper.screenHeight) /
      (LayoutHelper._designWidth * LayoutHelper._designHeight);
}