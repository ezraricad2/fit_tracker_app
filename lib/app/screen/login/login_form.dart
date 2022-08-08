
import 'package:fit_tracker_app/app/bloc/login/login_cubit.dart';
import 'package:fit_tracker_app/app/screen/home/dashboard_page.dart';
import 'package:fit_tracker_app/app/screen/home_page.dart';
import 'package:fit_tracker_app/app/screen/register_page.dart';
import 'package:fit_tracker_app/app/utilities/account_helper.dart';
import 'package:fit_tracker_app/app/utilities/assets.dart';
import 'package:fit_tracker_app/app/utilities/routing.dart';
import 'package:fit_tracker_app/app/utilities/textstyles.dart';
import 'package:fit_tracker_app/app/utilities/theme_helper.dart';
import 'package:fit_tracker_app/app/widget/commons.dart';
import 'package:fit_tracker_app/app/widget/mk_button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool isRemember = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true; // seen or unseen password

  @override
  void initState() {
    _cekSavedEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final double _imageSize = 100;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.all(28.0),
            child : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.logo,
                  width: _imageSize,
                ),
                SizedBox(height: 32),
                Text(
                  'Masuk ke Fit Tracker App',
                  style: p16.semiBold.darkestGrey,
                ),
                SizedBox(height: 24),
                Column(
                  children: [
                    TextFormField(
                      style: p14.darkestGrey,
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        hintStyle: p14.grey,
                        hintText: 'Email',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      style: p14.darkestGrey,
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        hintStyle: p14.grey,
                        hintText: 'Password',
                        isDense: true,
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(
                                  () {
                                _isObscure = !_isObscure;
                              },
                            );
                          },
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    SizedBox(height: 16),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) async {
                        if (state is NotLoadedLogin) {
                          Commons().snackbarError(context, '${state.error}');
                        }
                        if (state is LoadedLogin) {

                          String emailParam = await AccountHelper.getUserEmail();
                          Routing.pushReplacement(context, null, HomePage(emailParam : emailParam));
                        }
                      },
                      builder: (context, state) => state is LoadingLogin ?
                      MkButtonPrimaryLoading(color: systemAccentColor, height: 44) :
                      InkWell(
                        onTap: () => _login(),
                        radius: 8,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          alignment: Alignment.center,
                          height: 44,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: systemAccentColor,
                            border: Border.all(width: 1, color: systemAccentColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Masuk',
                            style: p14.semiBold.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Routing.push(
                          context,
                          null,
                            RegisterPage()
                        );
                      },
                      radius: 8,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        height: 44,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: systemLightGreyColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Daftar',
                          style: p14.semiBold.darkestGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  // method

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    print(regex.hasMatch(value));
    return regex.hasMatch(value);
  }

  void _validationForgotPassword() async {
    // if (_emailForgotPasswordController.text.length <= 0) {
    //   Commons().snackbarError(context, 'Email tidak boleh kosong');
    //   return;
    // }
    // if (!_validateEmail(_emailForgotPasswordController.text)) {
    //   Commons().snackbarError(context, 'Email tidak valid');
    //   return;
    // }
    //
    // final result = await APIRequest.account.executeForgotPassword(_emailForgotPasswordController.text);
    // if (result.value == 200) {
    //   Navigator.of(context).pop();
    //   Commons().snackbarNotification(context, 'Silahkan buka Email anda untuk mengganti Password', 3000);
    // } else {
    //   Navigator.of(context).pop();
    // }
  }

  void _login() async {

    // _emailController.text = "ezraricad2@gmail.com";
    // _passwordController.text = "123123";

    if (_emailController.text.length <= 0) {
      Commons().snackbarError(context, 'Email tidak boleh kosong');
      return;
    }
    if (!_validateEmail(_emailController.text)) {
      Commons().snackbarError(context, 'Email tidak valid');
      return;
    }
    if ((_passwordController.text?.length ?? 0) <= 0) {
      Commons().snackbarError(context, 'Password tidak boleh kosong');
      return;
    }

    context.read<LoginCubit>().fetchLogin(_emailController.text, _passwordController.text);
  }
}
