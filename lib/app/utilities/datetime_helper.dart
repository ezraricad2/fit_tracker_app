import 'package:intl/intl.dart';

const String kDateToStringSahabat = "yyyyMMdd";
const String kServerDateFormatSahabat = "yyyy-MM-ddThh:mm:ss.SSS";
const String kServerDateFormatVmsVendor = "yyyy-MM-dd hh:mm:ss.SSSSSS";
const String kServerDateFormatVms = "yyyy-MM-dd hh:mm:ss";
const String kServerDateFormatVmsShort = "yyyy-MM-dd";
const String kServerDateFormatQiscus = "yyyy-MM-ddThh:mm:ssZ";
const String kServerDateFormatVmsShort2 = "yyyy-MM-dd hh:mm";
const String kServerDateFormatDmy = "dd-MM-yyyy";
const String kServerDateFormatXendit = "yyyy-MM-ddThh:mm:ss.SSSZ";

class DateTimeHelper {
  static String dateToStringSahabat(DateTime date) {
    if (date == null) return null;

    DateFormat df = DateFormat(kDateToStringSahabat);

    return df.format(date);
  }

  static String dateToStringDmy(DateTime date) {
    if (date == null) return null;

    DateFormat df = DateFormat("d MMM yyyy");

    return df.format(date);
  }

  static String dateToStringYmd(DateTime date) {
    if (date == null) return null;

    DateFormat df = DateFormat("yyyy-M-d");

    return df.format(date);
  }

  static String dateToStringYmdhms(DateTime date) {
    if (date == null) return null;

    DateFormat df = DateFormat("yyyy-MM-dd hh:mm:ss");

    return df.format(date);
  }

  static DateTime stringToDateSahabat(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatSahabat);

    return df.parse(date);
  }

  static DateTime stringToDateQiscus(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatQiscus);

    return df.parse(date).add(Duration(hours: 7));
  }

  static DateTime stringToDateVms(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatVms);

    return df.parse(date);
  }

  static DateTime stringToDateXendit(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatXendit);

    return df.parse(date);
  }

  static DateTime stringToDateVmsVendor(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatVmsVendor);

    return df.parse(date);
  }

  static DateTime stringToDateVmsShort(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatVmsShort);

    return df.parse(date).add(Duration(hours: 7));
  }

  static DateTime stringToDateOnly(dynamic date) {
    if (date == null || !(date is String)) return null;

    DateFormat df = DateFormat(kServerDateFormatDmy);

    return df.parse(date).add(Duration(hours: 7));
  }

  static DateTime stringToDateVmsLong(dynamic date) {
    if (date == null) return null;

    DateTime newDate = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    //DateTime xx = dfNew.parse(newDate);
    return newDate;
  }
}
