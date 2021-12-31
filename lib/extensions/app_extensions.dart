import 'package:flutter/cupertino.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}


extension ScreenSizeExtension on double {
  double toScreenHeight(BuildContext context) {
    return this * MediaQuery.of(context).size.height / 926;
  }

  double toScreenWidth(BuildContext context) {
    return this * MediaQuery.of(context).size.width / 429;
  }
}