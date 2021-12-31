import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget phone;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({Key? key, required this.phone, required this.tablet, required this.desktop})
      : super(key: key);

  static int phoneLimit = 640;
  static int tabletLimit = 1200;

  static bool isPhone(BuildContext context) => MediaQuery.of(context).size.width < phoneLimit;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= phoneLimit && MediaQuery.of(context).size.width < tabletLimit;
  static bool isMacbook(BuildContext context) => MediaQuery.of(context).size.width >= tabletLimit;


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (MediaQuery.of(context).size.width < phoneLimit) {
        return phone;
      } else if (MediaQuery.of(context).size.width >= phoneLimit &&
          MediaQuery.of(context).size.width < tabletLimit) {
        return tablet;
      } else {
        return desktop;
      }
    });
  }
}
