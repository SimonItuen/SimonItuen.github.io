import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioButtonTile extends StatelessWidget {
  final String title;
  final int value;
  final Function(dynamic) onPressed;
  final int groupValue;
  final Color activeColor;

   const RadioButtonTile({Key? key, required this.title, required this.value, required this.onPressed, required this.groupValue, required this.activeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed(value);
      },
      child: Row(children: [
        Radio(
          value: value,
          groupValue: groupValue,
          activeColor: activeColor,
          onChanged: onPressed,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: activeColor,
              fontSize: 16),
        ),
      ]),
    );
  }
}