part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class InitialLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class LoadedLogin extends LoginState {}

class NotLoadedLogin extends LoginState {
  final String error;

  NotLoadedLogin({@required this.error});

  @override
  List<Object> get props => [error];
}
