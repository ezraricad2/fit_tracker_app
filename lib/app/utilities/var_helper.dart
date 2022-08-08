import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Converter {
  static int stringToInt(String current) {
    current = current ?? "0";

    return int.tryParse(current.isEmpty ? "0" : current) ?? 0;
  }

  static double stringToDouble(String current, {String format}) {
    current = current ?? "0";

    if ((format ?? "").isEmpty) {
      return double.tryParse(current.isEmpty ? "0" : current) ?? 0;
    } else {
      NumberFormat nf = NumberFormat(format);

      return nf.parse(current.isEmpty ? "0" : current) ?? 0;
    }
  }

  static String intToString(int current, {String format}) {
    current ??= 0;

    if ((format ?? "").isEmpty) {
      return "$current";
    } else {
      NumberFormat nf = NumberFormat(format);

      return nf.format(current);
    }
  }
}

ValueNotifier<int> tabIndex = ValueNotifier<int>(0);