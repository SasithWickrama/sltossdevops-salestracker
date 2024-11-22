import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/asset_constants.dart';

class UtilFunction {
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  static String getDuration(int x) {
    Duration duration = Duration(seconds: x);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inDays)} $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  static void callNumber(String number) {
    if (number.length == 10) {
      Uri tp = Uri(scheme: "tel", path: number);
      launchUrl(tp);
    }
  }
}
