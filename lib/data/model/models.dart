
import 'package:fit_tracker_app/app/utilities/datetime_helper.dart';

abstract class Model {
  static String castString(var object, [String defaultValue]) {
    defaultValue = "";

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as String;
  }

  static int castInt(var object, [int defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toInt();
      } else if (object is String) {
        return int.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static double castDouble(var object, [double defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toDouble();
      } else if (object is String) {
        return double.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static bool castBool(var object, [bool defaultValue]) {
    defaultValue = false;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is bool) {
        return object;
      } else if (object is String) {
        return object == "1" ? true : false;
      } else if (object is num) {
        return object == 1 ? true : false;
      } else {
        return null;
      }
    }
  }

  static DateTime castDateVms(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateVms(object);
  }

  static DateTime castDateVmsLong(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateVmsLong(object);
  }

  static DateTime castDateQiscus(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateQiscus(object);
  }

  static DateTime castDateVmsVendor(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateVmsVendor(object);
  }

  static DateTime castDateVmsShort(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateVmsShort(object);
  }

  static DateTime castDateSahabat(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateSahabat(object);
  }

  static DateTime castDateXendit(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateXendit(object);
  }

  static DateTime castDateOnly(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : DateTimeHelper.stringToDateOnly(object);
  }


  static List castList(var object, [List defaultValue]) {
    defaultValue = [];

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as List;
  }
}
