import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tracker_app/app/utilities/account_helper.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:flutter/cupertino.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void isHasToken() async {
    try {
      final String userToken = await AccountHelper.getUserUuid();
      final String userEmail = await AccountHelper.getUserEmail();
      await Future.delayed(Duration(seconds: 3));
      if (userToken != null) {
        emit(Authenticated(email: userEmail));
      } else {
        emit(NotAuthenticated());
      }
    } catch (_) {
      emit(NotAuthenticated());
    }
  }

  Future<void> loggedIn(String uuid, String email, String name, String gender, String dob, String height) async {
    await AccountHelper.saveUserInfo(uuid, email, name, gender, dob, height);
    emit(Authenticated(email: email));
  }

  void logout() {
    // TODO: implement hapus user info
  }
}
