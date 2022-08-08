import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/theme_helper.dart';

class LoadingInPage extends StatelessWidget {
  final double size;
  final Color color;

  LoadingInPage({this.size = 30, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        strokeWidth: 4,
        backgroundColor: systemWhiteColor,
        valueColor: new AlwaysStoppedAnimation<Color>(color ?? systemAccentColor),
      ),
    );
  }
}
