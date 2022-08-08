import 'package:flutter/material.dart';
import 'home_container.dart';

class HomePage extends StatelessWidget {

  final String emailParam;

  HomePage({this.emailParam});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: HomeContainer(emailParam : emailParam)
    );
  }
}
