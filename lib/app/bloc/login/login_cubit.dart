import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_tracker_app/app/bloc/authentication/authentication_cubit.dart';
import 'package:fit_tracker_app/app/utilities/constants.dart';
import 'package:fit_tracker_app/app/utilities/var_helper.dart';
import 'package:fit_tracker_app/data/model/response_model.dart';
import 'package:fit_tracker_app/data/repository/engine_auth_dev.dart';
import 'package:flutter/foundation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationCubit authenticationCubit;

  LoginCubit(this.authenticationCubit) : super(InitialLogin());

  void fetchLogin(String username, String password) async {
    try {
      emit(LoadingLogin());

      final result = await APIRequest.account.loginUser(
          email: username, password: password);

      if (result.user.uid != null) {

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('user').get();

        querySnapshot.docs.map((doc) => doc.data()).toList().forEach((element) {
          if(element['Email'] == username)
          {
            authenticationCubit.loggedIn(result.user.uid, element['Email'], element['Name'], element['Gender'], element['Dob'].toString(), element['Height'].toString());
          }
        });

        tabIndex.value = 0;
        emit(LoadedLogin());
      } else {
        emit(NotLoadedLogin(error: 'Login gagal'));
      }
    } catch (error) {
      emit(NotLoadedLogin(error: 'Login gagal ${error.toString()}'));
    }
  }
}
