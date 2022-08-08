import 'dart:io';

import 'package:fit_tracker_app/app/utilities/assets.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              systemAccent300Color,
              systemAccent300Color,
              systemAccent400Color,
              systemAccentColor,
              systemAccentColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Image.asset(
          Assets.logo,
          height: 150,
        ),
      ),
    );
  }
}
