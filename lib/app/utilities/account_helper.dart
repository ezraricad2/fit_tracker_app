
import 'package:fit_tracker_app/app/utilities/preference_keys.dart';
import 'package:fit_tracker_app/data/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountHelper {

  static Future<void> saveUserUuid(String uuid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kId, uuid);
  }

  static Future<String> getUserUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kId);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(kEmail);
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(kId);
    prefs.remove(kEmail);
    prefs.remove(kName);
    prefs.remove(kGender);
    prefs.remove(kDob);
    prefs.remove(kHeight);
  }

  static Future<void> saveUserInfo(String uuid, String email, String name, String gender, String dob, String height) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(kId, uuid);
    prefs.setString(kEmail, email);
    prefs.setString(kName, name);
    prefs.setString(kGender, gender);
    prefs.setString(kDob, dob);
    prefs.setString(kHeight, height);
  }

}
