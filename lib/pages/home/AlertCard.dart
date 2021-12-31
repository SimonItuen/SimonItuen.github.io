import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';

class AlertCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AlertCardState();
}

class AlertCardState extends State {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Send Alert',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text('To',
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
            Row(
              children: [
                Expanded(
                    child: CheckboxListTile(
                  value: false,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {},
                  title: Text('Valid', style: TextStyle(fontSize: 10)),
                )),
                Expanded(
                    child: CheckboxListTile(
                  value: false,
                  onChanged: (value) {},
                  title: Text('Invalid', style: TextStyle(fontSize: 10)),
                )),
                Expanded(
                    child: CheckboxListTile(
                  value: false,
                  onChanged: (value) {},
                  title: Text('Valid', style: TextStyle(fontSize: 10)),
                )),
              ],
            ),
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2),
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(5),
                  )),
            )),
          ],
        ),
      ),
    );
  }
}
