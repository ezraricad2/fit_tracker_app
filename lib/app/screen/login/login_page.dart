import 'package:fit_tracker_app/app/bloc/authentication/authentication_cubit.dart';
import 'package:fit_tracker_app/app/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthenticationCubit()),
        child: LoginForm(),
      ),
    );
  }
}
