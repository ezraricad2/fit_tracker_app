
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker_app/data/model/models.dart';


class ResponseModel extends Model {
  ResponseModel({
    this.success,
    this.messages,
  });

  bool success;
  String messages;

}
