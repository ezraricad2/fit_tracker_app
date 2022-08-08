import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tracker_app/app/bloc/authentication/authentication_cubit.dart';
import 'package:fit_tracker_app/app/screen/home_page.dart';
import 'package:fit_tracker_app/app/screen/login/login_page.dart';
import 'package:fit_tracker_app/app/screen/splash/splash.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider<AuthenticationCubit>(
      create: (context) => AuthenticationCubit()..isHasToken(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('id', 'ID'), // Hebrew
      ],
      theme: new ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
          brightness: Brightness.light,
          primarySwatch: CompanyColors.accent,
          primaryColor: CompanyColors.accent[500],
          primaryColorBrightness: Brightness.light,
          accentColor: CompanyColors.primary[500],
          scaffoldBackgroundColor: scaffoldColor,
          fontFamily: "Roboto-Black",
          accentColorBrightness: Brightness.light),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return SplashPage();
          } else if (state is Authenticated) {
            return HomePage(emailParam: state.email);
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
