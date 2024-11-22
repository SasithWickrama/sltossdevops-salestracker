import 'package:flutter/cupertino.dart';

class SizeConfig {
  static double h(BuildContext c) => MediaQuery.of(c).size.height;

  static double w(BuildContext c) => MediaQuery.of(c).size.width;

  static bool isSmallScreen(BuildContext c) =>
      MediaQuery.of(c).size.width < 600;
}
