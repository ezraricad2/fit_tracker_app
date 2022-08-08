import 'package:fit_tracker_app/app/widget/mk_loading_inpage.dart';
import 'package:flutter/material.dart';

class MkButtonPrimaryLoading extends StatelessWidget {
  final Color color;
  final double height;

  MkButtonPrimaryLoading({this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height != null ? height : 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: LoadingInPage(size: 20, color: color),
    );
  }
}
