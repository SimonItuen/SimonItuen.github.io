import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vaksine_web/widget/ResponsiveLayout.dart';

class DiseasesTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPress;

  DiseasesTile(
      {Key? key,
      required this.title,
      this.isSelected =false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        phone: Card(
          color: isSelected?Colors.blueGrey:Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 14),
              ),
            ),
          ),
        ),
        tablet: Card(
          color: isSelected?Colors.blueGrey:Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 14),
              ),
            ),
          ),
        ),
        desktop: Card(
          color: isSelected?Colors.blueGrey:Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadowColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected?Colors.white:Theme.of(context).primaryColor, fontSize: 16),
              ),
            ),
          ),
        ));
  }
}
