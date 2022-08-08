
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker_app/data/model/models.dart';


class LoginModel extends Model {
  LoginModel({
    this.email,
    this.name,
    this.gender,
    this.dob,
    this.height,
  });

  String email;
  String name;
  String gender;
  String dob;
  String height;

  factory LoginModel.fromJson(String email, String name, String gender, String dob, String height) => LoginModel(
    email: Model.castString(email),
    name: Model.castString(name),
    gender: Model.castString(gender == 'L' ? "male" : "female"),
    dob: Model.castString(dob),
    height: Model.castString(height),
  );
}
