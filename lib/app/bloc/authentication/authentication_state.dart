part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String email;

  Authenticated({@required this.email});

  @override
  List<Object> get props => [this.email];
}

class NotAuthenticated extends AuthenticationState {}
