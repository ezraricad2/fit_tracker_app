import 'package:bloc/bloc.dart';

class ChangeRememberMeCubit extends Cubit<bool> {
  ChangeRememberMeCubit() : super(false);

  changeRemember(bool val) => emit(!val);
}
